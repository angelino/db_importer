class CreateMicrosigaEntries < ActiveRecord::Migration
  def change
    create_table :microsiga_entries do |t|
      t.string :status_oper
      t.string :cnpj_cpf
      t.string :tipo_mapfre
      t.string :fornecedor
      t.string :loja
      t.string :nom_forn
      t.string :tipo_rubrica
      t.string :prefixo
      t.string :no_titulo
      t.string :parcela
      t.string :natureza
      t.string :banco_dest
      t.string :agencia_dest
      t.string :conta_dest
      t.date :dt_emissao
      t.string :vencimento
      t.string :vencto_real
      t.decimal :vlr_titulo, precision: 12, scale: 2
      t.decimal :vl_original, precision: 12, scale: 2
      t.string :portador
      t.string :iss
      t.string :irrf
      t.string :inss
      t.string :pis_pasep
      t.string :cofins
      t.string :csll
      t.string :n_do_cheque
      t.string :historico
      t.string :motivo
      t.string :rateio
      t.decimal :vlr_rs, precision: 12, scale: 2
      t.string :mult_natur
      t.string :rateio_proj
      t.string :gera_dirf
      t.string :mod_pagto
      t.string :local_pagto
      t.string :cod_agencia
      t.string :cod_congener
      t.string :cod_pag
      t.string :cod_empresa
      t.string :cod_corretor
      t.string :cod_ramo
      t.string :num_liq_sin
      t.string :num_sinistro
      t.string :num_original
      t.string :tributo
      t.string :num_remessa
      t.string :banco_origem
      t.string :ag_origem
      t.string :id_cnab_mapf
      t.string :id_mapfre
      t.string :env_cheque
      t.string :enviado
      t.string :rejeitado
      t.date :dt_import
      t.date :dt_exportaca
      t.string :boleto
      t.string :tributo2
      t.string :vida_prev
      t.date :dt_ger_pagto
      t.date :dt_cancel_ch
      t.string :est_enviado
      t.string :cheque_pend
      t.string :baixa_agluti
      t.string :cnpj_2
      t.date :data_compens
      t.string :conta_origem
      t.date :data_exp_rj
      t.string :nr_orig_sisp
      t.string :n_etiq_siacc
      t.string :a
      t.string :b
      t.string :c
      t.string :d
      t.string :e
      t.string :f
      t.string :g
      t.string :h
      t.string :i
      t.string :j
      t.string :k

      t.timestamps null: false
    end
  end
end
