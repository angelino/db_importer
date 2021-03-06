import multiprocessing
import subprocess
import re
import argparse
import os
import time


LEDGER_HEADER = 'Ledger,Account,Period,Transaction Date,Journal,Line No.,Base Amt,Signal Base Amt,Debit Credit marker,Reference,Description,Journal Type,Journal Source,Other Amt,Signal Other Amt,Conversion Code,Rate,TCode 0,TCode 1,TCode 2,TCode 3,TCode 4,TCode 5,TCode 6,TCode 7,TCode 8,TCode 9,Alloc Ind.,Alloc Ref.,Alloc Period,Alloc Date,Asset Indicator,Asset Code,Asset Sub-code,Entry Date,Entry Period,Due Date,Entry OP,Post OP,Amend Op,Rough Book\n'
MICROSIGA_HEADER = 'Status Oper,CNPJ CPF,Tipo Mapfre,Fornecedor,Loja,Nom Forn,Tipo Rubrica,Prefixo,No Titulo,Parcela,Natureza,Banco Dest,Agencia Dest,Conta Dest,DT Emissao,Vencimento,Vencto Real,Vlr Titulo,Vl Original,Portador,ISS,IRRF,INSS,PIS PASEP,COFINS,CSLL,N do Cheque,Historico,Motivo,Rateio,Vlr RS,Mult Natur,Rateio Proj,Gera Dirf,Mod Pagto,Local Pagto,Cod Agencia,Cod Congener,Cod Pag,Cod Empresa,Cod Corretor,Cod Ramo,Num Liq Sin,Num Sinistro,Num Original,Tributo,Num Remessa,Banco Origem,Ag Origem,ID Cnab Mapf,ID Mapfre,Env Cheque,Enviado,Rejeitado,DT IMPORT,Dt Exportaca,Boleto,Tributo2,Vida Prev,Dt Ger Pagto,Dt Cancel CH,Est Enviado,Cheque Pend,Baixa Agluti,cnpj 2,Data Compens,Conta Origem,Data Exp RJ,Nr Orig SisP,N Etiq SIACC\n'


def drange(start, stop, step):
    r = (start)
    while r < stop:
        last = (r + step) - 1
        if last > stop:
            last = stop
        yield r, last
        r += step


def split_file(filename, header, nlines=25000, start=2):
    proc = subprocess.Popen(['wc','-l', filename], stdout=subprocess.PIPE)
    output = proc.stdout.read()
    stop = int(re.findall(r'\d+', output)[0])
    intervals = drange(start, stop, nlines)
    basename, extension = filename.split('.')
    files = []
    filenumber = 1
    for start, stop in intervals:
        output_file = '%s-%d.%s' % (basename, filenumber, extension)
        f = open(output_file,'w')
        f.write(header)
        f.truncate()
        f.close()
        f = open(output_file,'a')
        sed = ["sed","-n", "%d,%dp" % (start, stop), filename]
        exit_code = subprocess.call(sed, stdout=f)
        if (exit_code != 0):
            raise Exception("Could not write file %s" % output_file)
        f.close()
        files.append(output_file)
        filenumber += 1
    return files


def split_microsiga(filename):
    return split_file(filename, MICROSIGA_HEADER)


def split_extract(filename):
    return split_file(filename, LEDGER_HEADER)


def split_ledger(filename):
    return split_file(filename, LEDGER_HEADER)


def ledger_importer(ledger):
    command = ['rake', 'msit:import', 'ledgers_file=%s' % ledger]
    exit_code = subprocess.call(command)


def extract_importer(extract):
    command = ['rake', 'msit:import', 'extracts_file=%s' % extract]
    exit_code = subprocess.call(command)


def microsiga_importer(microsiga):
    command = ['rake', 'msit:import', 'microsiga_file=%s' % microsiga]
    exit_code = subprocess.call(command)


def process_files(worker, files):
    nworkers = int(multiprocessing.cpu_count() / 3)
    print 'Workers number:', nworkers
    pool = multiprocessing.Pool(nworkers)
    for f in files:
        pool.apply_async(worker, (f,))
    pool.close()
    pool.join()
    #result = pool.apply(worker, (files[0],))
    #procs = []
    #for f in files:
    #    p = multiprocessing.Process(
    #        target=worker, args=(f, rakefile))
    #    procs.append(p)
    #    p.start()

    #for i in procs:
    #    i.join()
        # rake is always returning 0 !!!
        #if i.exitcode != 0:
        #    raise Exception('Bad importation')


if __name__ == '__main__':

    start_time = time.time()
    parser = argparse.ArgumentParser()
    parser.add_argument('--ledgers', required=False)
    parser.add_argument('--microsiga', required=False)
    parser.add_argument('--extracts', required=False)

    args = parser.parse_args()
    ledgers = args.ledgers
    microsiga = args.microsiga
    extracts = args.extracts

    if ledgers is not None:
        ledgers = split_ledger(ledgers)
        process_files(ledger_importer, ledgers)

    if microsiga is not None:
        microsigas = split_microsiga(microsiga)
        process_files(microsiga_importer, microsigas)

    if extracts is not None:
        extracts = split_extract(extracts)
        process_files(extract_importer, extracts)

    elapsed_time = time.time() - start_time
    print "Elapsed time:", elapsed_time
