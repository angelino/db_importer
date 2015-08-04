#!/bin/bash
#cria arquivos com cabecalho
header='Status Oper,CNPJ CPF,Tipo Mapfre,Fornecedor,Loja,Nom Forn,Tipo Rubrica,Prefixo,No Titulo,Parcela,Natureza,Banco Dest,Agencia Dest,Conta Dest,DT Emissao,Vencimento,Vencto Real,Vlr Titulo,Vl Original,Portador,ISS,IRRF,INSS,PIS PASEP,COFINS,CSLL,N do Cheque,Historico,Motivo,Rateio,Vlr RS,Mult Natur,Rateio Proj,Gera Dirf,Mod Pagto,Local Pagto,Cod Agencia,Cod Congener,Cod Pag,Cod Empresa,Cod Corretor,Cod Ramo,Num Liq Sin,Num Sinistro,Num Original,Tributo,Num Remessa,Banco Origem,Ag Origem,ID Cnab Mapf,ID Mapfre,Env Cheque,Enviado,Rejeitado,DT IMPORT,Dt Exportaca,Boleto,Tributo2,Vida Prev,Dt Ger Pagto,Dt Cancel CH,Est Enviado,Cheque Pend,Baixa Agluti,cnpj 2,Data Compens,Conta Origem,Data Exp RJ,Nr Orig SisP,N Etiq SIACC'

echo $header > microsiga-empty.csv
