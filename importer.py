import multiprocessing
import subprocess
import re
import argparse
import os


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


def ledger_importer(ledger, rakefile=None):
    command = ['rake', 'msit:import', 'ledgers_file=%s' % ledger]
    if rakefile is not None:
        command.append('-f %s' % rakefile)
    exit_code = subprocess.call(command)


def extract_importer(extract, rakefile=None):
    command = ['rake', 'msit:import', 'extracts_file=%s' % extract]
    if rakefile is not None:
        command.append('-f %s' % rakefile)
    exit_code = subprocess.call(command)


def microsiga_importer(microsiga, rakefile=None):
    command = ['rake', 'msit:import', 'microsiga_file=%s' % microsiga]
    if rakefile is not None:
        command.append('-f %s' % rakefile)
    exit_code = subprocess.call(command)


def process_files(files, worker, rakefile=None):
    procs = []
    for f in files:
        p = multiprocessing.Process(
            target=worker, args=(f, rakefile))
        procs.append(p)
        p.start()

    for i in procs:
        i.join()
        # rake is always returning 0 !!!
        #if i.exitcode != 0:
        #    raise Exception('Bad importation')


if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument('--ledgers', required=False)
    parser.add_argument('--microsiga', required=False)
    parser.add_argument('--extracts', required=False)
    parser.add_argument('--rakefile', required=False)

    args = parser.parse_args()
    ledgers = args.ledgers
    microsiga = args.microsiga
    extracts = args.extracts
    rakefile = args.rakefile

    if ledgers is not None:
        ledgers = split_ledger(ledgers)
        process_files(ledgers, ledger_importer, rakefile)

    if microsiga is not None:
        microsigas = split_microsiga(microsiga)
        process_files(microsigas, microsiga_importer, rakefile)

    if extracts is not None:
        extracts = split_extract(extract)
        process_files(extracts, extract_importer, rakefile)