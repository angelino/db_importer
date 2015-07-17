#!/bin/bash
#cria arquivos com cabecalho
header='"Ledger","Account","Period","Transaction Date","Journal","Line No","Base Amt","Signal Base Amt","Debit Credit Marker","Reference","Description","Journal Type","Journal Source","Other Amt","Signal Other Amt","Conversion Code","Rate","TCode 0","TCode 1","TCode 2","TCode 3","TCode 4","TCode 5","TCode 6","TCode 7","TCode 8","TCode 9","Alloc Ind","Alloc Ref","Alloc Period","Alloc Date","Asset Indicator","Asset Code","Asset Sub-code","Entry Date","Entry Period","Due Date","Entry OP","Post OP","Amend Op","Rough Book"'

echo $header > extracts-empty.csv
echo $header > extracts-1.csv
echo $header > extracts-2.csv
echo $header > extracts-3.csv
echo $header > extracts-4.csv
echo $header > extracts-5.csv
echo $header > extracts-6.csv
echo $header > extracts-7.csv
echo $header > extracts-8.csv
echo $header > extracts-9.csv
echo $header > extracts-10.csv
echo $header > extracts-11.csv
echo $header > extracts-12.csv
echo $header > extracts-13.csv

echo $header > ledgers-1.csv
echo $header > ledgers-2.csv
echo $header > ledgers-3.csv
echo $header > ledgers-4.csv
echo $header > ledgers-5.csv
echo $header > ledgers-6.csv
echo $header > ledgers-7.csv
echo $header > ledgers-8.csv
echo $header > ledgers-9.csv
echo $header > ledgers-10.csv
echo $header > ledgers-11.csv
echo $header > ledgers-12.csv
echo $header > ledgers-13.csv
echo $header > ledgers-14.csv
echo $header > ledgers-15.csv
echo $header > ledgers-16.csv
echo $header > ledgers-17.csv
echo $header > ledgers-18.csv
echo $header > ledgers-19.csv
echo $header > ledgers-20.csv
echo $header > ledgers-21.csv
echo $header > ledgers-22.csv
echo $header > ledgers-23.csv
echo $header > ledgers-24.csv
echo $header > ledgers-25.csv
echo $header > ledgers-26.csv
echo $header > ledgers-27.csv
echo $header > ledgers-28.csv
echo $header > ledgers-29.csv
echo $header > ledgers-30.csv
echo $header > ledgers-31.csv
echo $header > ledgers-32.csv
echo $header > ledgers-33.csv

echo $header > ledgers2-1.csv
echo $header > ledgers2-2.csv
echo $header > ledgers2-3.csv
echo $header > ledgers2-4.csv
echo $header > ledgers2-5.csv
echo $header > ledgers2-6.csv
echo $header > ledgers2-7.csv
echo $header > ledgers2-8.csv
echo $header > ledgers2-9.csv
echo $header > ledgers2-10.csv
echo $header > ledgers2-11.csv

#extracts: 
sed -n '2,25001p' extracts.csv >> extracts-1.csv
sed -n '25002,50001p' extracts.csv >> extracts-2.csv
sed -n '50002,75001p' extracts.csv >> extracts-3.csv
sed -n '75002,100001p' extracts.csv >> extracts-4.csv
sed -n '100002,125001p' extracts.csv >> extracts-5.csv
sed -n '125002,150001p' extracts.csv >> extracts-6.csv
sed -n '150002,175001p' extracts.csv >> extracts-7.csv
sed -n '175002,200001p' extracts.csv >> extracts-8.csv
sed -n '200002,225001p' extracts.csv >> extracts-9.csv
sed -n '225002,250001p' extracts.csv >> extracts-10.csv
sed -n '250002,275001p' extracts.csv >> extracts-11.csv
sed -n '275002,300001p' extracts.csv >> extracts-12.csv
sed -n '300002,325001p' extracts.csv >> extracts-13.csv

#ledgers: 
sed -n '2,25001p' ledgers.csv >> ledgers-1.csv
sed -n '25002,50001p' ledgers.csv >> ledgers-2.csv
sed -n '50002,75001p' ledgers.csv >> ledgers-3.csv
sed -n '75002,100001p' ledgers.csv >> ledgers-4.csv
sed -n '100002,125001p' ledgers.csv >> ledgers-5.csv
sed -n '125002,150001p' ledgers.csv >> ledgers-6.csv
sed -n '150002,175001p' ledgers.csv >> ledgers-7.csv
sed -n '175002,200001p' ledgers.csv >> ledgers-8.csv
sed -n '200002,225001p' ledgers.csv >> ledgers-9.csv
sed -n '225002,250001p' ledgers.csv >> ledgers-10.csv
sed -n '250002,275001p' ledgers.csv >> ledgers-11.csv
sed -n '275002,300001p' ledgers.csv >> ledgers-12.csv
sed -n '300002,325001p' ledgers.csv >> ledgers-13.csv
sed -n '325002,350001p' ledgers.csv >> ledgers-14.csv
sed -n '350002,375001p' ledgers.csv >> ledgers-15.csv
sed -n '375002,400001p' ledgers.csv >> ledgers-16.csv
sed -n '400002,425001p' ledgers.csv >> ledgers-17.csv
sed -n '425002,450001p' ledgers.csv >> ledgers-18.csv
sed -n '450002,475001p' ledgers.csv >> ledgers-19.csv
sed -n '475002,500001p' ledgers.csv >> ledgers-20.csv
sed -n '500002,525001p' ledgers.csv >> ledgers-21.csv
sed -n '525002,550001p' ledgers.csv >> ledgers-22.csv
sed -n '550002,575001p' ledgers.csv >> ledgers-23.csv
sed -n '575002,600001p' ledgers.csv >> ledgers-24.csv
sed -n '600002,625001p' ledgers.csv >> ledgers-25.csv
sed -n '625002,650001p' ledgers.csv >> ledgers-26.csv
sed -n '650002,675001p' ledgers.csv >> ledgers-27.csv
sed -n '675002,700001p' ledgers.csv >> ledgers-28.csv
sed -n '700002,725001p' ledgers.csv >> ledgers-29.csv
sed -n '725002,750001p' ledgers.csv >> ledgers-30.csv
sed -n '750002,775001p' ledgers.csv >> ledgers-31.csv
sed -n '775002,800001p' ledgers.csv >> ledgers-32.csv
sed -n '800002,825001p' ledgers.csv >> ledgers-33.csv

#ledgers2:
sed -n '2,25001p' ledgers2.csv >> ledgers2-1.csv
sed -n '25002,50001p' ledgers2.csv >> ledgers2-2.csv
sed -n '50002,75001p' ledgers2.csv >> ledgers2-3.csv
sed -n '75002,100001p' ledgers2.csv >> ledgers2-4.csv
sed -n '100002,125001p' ledgers2.csv >> ledgers2-5.csv
sed -n '125002,150001p' ledgers2.csv >> ledgers2-6.csv
sed -n '150002,175001p' ledgers2.csv >> ledgers2-7.csv
sed -n '175002,200001p' ledgers2.csv >> ledgers2-8.csv
sed -n '200002,225001p' ledgers2.csv >> ledgers2-9.csv
sed -n '225002,250001p' ledgers2.csv >> ledgers2-10.csv
sed -n '250002,275001p' ledgers2.csv >> ledgers2-11.csv