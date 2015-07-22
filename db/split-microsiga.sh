#!/bin/bash
#cria arquivos com cabecalho
header='Status Oper,CNPJ CPF,Tipo Mapfre,Fornecedor,Loja,Nom Forn,Tipo Rubrica,Prefixo,No Titulo,Parcela,Natureza,Banco Dest,Agencia Dest,Conta Dest,DT Emissao,Vencimento,Vencto Real,Vlr Titulo,Vl Original,Portador,ISS,IRRF,INSS,PIS PASEP,COFINS,CSLL,N do Cheque,Historico,Motivo,Rateio,Vlr RS,Mult Natur,Rateio Proj,Gera Dirf,Mod Pagto,Local Pagto,Cod Agencia,Cod Congener,Cod Pag,Cod Empresa,Cod Corretor,Cod Ramo,Num Liq Sin,Num Sinistro,Num Original,Tributo,Num Remessa,Banco Origem,Ag Origem,ID Cnab Mapf,ID Mapfre,Env Cheque,Enviado,Rejeitado,DT IMPORT,Dt Exportaca,Boleto,Tributo2,Vida Prev,Dt Ger Pagto,Dt Cancel CH,Est Enviado,Cheque Pend,Baixa Agluti,cnpj 2,Data Compens,Conta Origem,Data Exp RJ,Nr Orig SisP,N Etiq SIACC'

echo $header > microsiga-1.csv
echo $header > microsiga-2.csv
echo $header > microsiga-3.csv
echo $header > microsiga-4.csv
echo $header > microsiga-5.csv
echo $header > microsiga-6.csv
echo $header > microsiga-7.csv

#microsiga:
sed -n '2,25001p' microsiga.csv >> microsiga-1.csv
sed -n '25002,50001p' microsiga.csv >> microsiga-2.csv
sed -n '50002,75001p' microsiga.csv >> microsiga-3.csv
sed -n '75002,100001p' microsiga.csv >> microsiga-4.csv
sed -n '100002,125001p' microsiga.csv >> microsiga-5.csv
sed -n '125002,150001p' microsiga.csv >> microsiga-6.csv
sed -n '150002,175001p' microsiga.csv >> microsiga-7.csv