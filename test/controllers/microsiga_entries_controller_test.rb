require 'test_helper'

class MicrosigaEntriesControllerTest < ActionController::TestCase
  setup do
    @microsiga_entry = microsiga_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:microsiga_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create microsiga_entry" do
    assert_difference('MicrosigaEntry.count') do
      post :create, microsiga_entry: { a: @microsiga_entry.a, ag_origem: @microsiga_entry.ag_origem, agencia_dest: @microsiga_entry.agencia_dest, b: @microsiga_entry.b, baixa_agluti: @microsiga_entry.baixa_agluti, banco_dest: @microsiga_entry.banco_dest, banco_origem: @microsiga_entry.banco_origem, boleto: @microsiga_entry.boleto, c: @microsiga_entry.c, cheque_pend: @microsiga_entry.cheque_pend, cnpj_2: @microsiga_entry.cnpj_2, cnpj_cpf: @microsiga_entry.cnpj_cpf, cod_agencia: @microsiga_entry.cod_agencia, cod_congener: @microsiga_entry.cod_congener, cod_corretor: @microsiga_entry.cod_corretor, cod_empresa: @microsiga_entry.cod_empresa, cod_pag: @microsiga_entry.cod_pag, cod_ramo: @microsiga_entry.cod_ramo, cofins: @microsiga_entry.cofins, conta_dest: @microsiga_entry.conta_dest, conta_origem: @microsiga_entry.conta_origem, csll: @microsiga_entry.csll, d: @microsiga_entry.d, data_compens: @microsiga_entry.data_compens, data_exp_rj: @microsiga_entry.data_exp_rj, dt_cancel_ch: @microsiga_entry.dt_cancel_ch, dt_emissao: @microsiga_entry.dt_emissao, dt_exportaca: @microsiga_entry.dt_exportaca, dt_ger_pagto: @microsiga_entry.dt_ger_pagto, dt_import: @microsiga_entry.dt_import, e: @microsiga_entry.e, env_cheque: @microsiga_entry.env_cheque, enviado: @microsiga_entry.enviado, est_enviado: @microsiga_entry.est_enviado, f: @microsiga_entry.f, fornecedor: @microsiga_entry.fornecedor, g: @microsiga_entry.g, gera_dirf: @microsiga_entry.gera_dirf, h: @microsiga_entry.h, historico: @microsiga_entry.historico, i: @microsiga_entry.i, id_cnab_mapf: @microsiga_entry.id_cnab_mapf, id_mapfre: @microsiga_entry.id_mapfre, inss: @microsiga_entry.inss, irrf: @microsiga_entry.irrf, iss: @microsiga_entry.iss, j: @microsiga_entry.j, k: @microsiga_entry.k, local_pagto: @microsiga_entry.local_pagto, loja: @microsiga_entry.loja, mod_pagto: @microsiga_entry.mod_pagto, motivo: @microsiga_entry.motivo, mult_natur: @microsiga_entry.mult_natur, n_do_cheque: @microsiga_entry.n_do_cheque, n_etiq_siacc: @microsiga_entry.n_etiq_siacc, natureza: @microsiga_entry.natureza, no_titulo: @microsiga_entry.no_titulo, nom_forn: @microsiga_entry.nom_forn, nr_orig_sisp: @microsiga_entry.nr_orig_sisp, num_liq_sin: @microsiga_entry.num_liq_sin, num_original: @microsiga_entry.num_original, num_remessa: @microsiga_entry.num_remessa, num_sinistro: @microsiga_entry.num_sinistro, parcela: @microsiga_entry.parcela, pis_pasep: @microsiga_entry.pis_pasep, portador: @microsiga_entry.portador, prefixo: @microsiga_entry.prefixo, rateio: @microsiga_entry.rateio, rateio_proj: @microsiga_entry.rateio_proj, rejeitado: @microsiga_entry.rejeitado, status_oper: @microsiga_entry.status_oper, tipo_mapfre: @microsiga_entry.tipo_mapfre, tipo_rubrica: @microsiga_entry.tipo_rubrica, tributo2: @microsiga_entry.tributo2, tributo: @microsiga_entry.tributo, vencimento: @microsiga_entry.vencimento, vencto_real: @microsiga_entry.vencto_real, vida_prev: @microsiga_entry.vida_prev, vl_original: @microsiga_entry.vl_original, vlr_rs: @microsiga_entry.vlr_rs, vlr_titulo: @microsiga_entry.vlr_titulo }
    end

    assert_redirected_to microsiga_entry_path(assigns(:microsiga_entry))
  end

  test "should show microsiga_entry" do
    get :show, id: @microsiga_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @microsiga_entry
    assert_response :success
  end

  test "should update microsiga_entry" do
    patch :update, id: @microsiga_entry, microsiga_entry: { a: @microsiga_entry.a, ag_origem: @microsiga_entry.ag_origem, agencia_dest: @microsiga_entry.agencia_dest, b: @microsiga_entry.b, baixa_agluti: @microsiga_entry.baixa_agluti, banco_dest: @microsiga_entry.banco_dest, banco_origem: @microsiga_entry.banco_origem, boleto: @microsiga_entry.boleto, c: @microsiga_entry.c, cheque_pend: @microsiga_entry.cheque_pend, cnpj_2: @microsiga_entry.cnpj_2, cnpj_cpf: @microsiga_entry.cnpj_cpf, cod_agencia: @microsiga_entry.cod_agencia, cod_congener: @microsiga_entry.cod_congener, cod_corretor: @microsiga_entry.cod_corretor, cod_empresa: @microsiga_entry.cod_empresa, cod_pag: @microsiga_entry.cod_pag, cod_ramo: @microsiga_entry.cod_ramo, cofins: @microsiga_entry.cofins, conta_dest: @microsiga_entry.conta_dest, conta_origem: @microsiga_entry.conta_origem, csll: @microsiga_entry.csll, d: @microsiga_entry.d, data_compens: @microsiga_entry.data_compens, data_exp_rj: @microsiga_entry.data_exp_rj, dt_cancel_ch: @microsiga_entry.dt_cancel_ch, dt_emissao: @microsiga_entry.dt_emissao, dt_exportaca: @microsiga_entry.dt_exportaca, dt_ger_pagto: @microsiga_entry.dt_ger_pagto, dt_import: @microsiga_entry.dt_import, e: @microsiga_entry.e, env_cheque: @microsiga_entry.env_cheque, enviado: @microsiga_entry.enviado, est_enviado: @microsiga_entry.est_enviado, f: @microsiga_entry.f, fornecedor: @microsiga_entry.fornecedor, g: @microsiga_entry.g, gera_dirf: @microsiga_entry.gera_dirf, h: @microsiga_entry.h, historico: @microsiga_entry.historico, i: @microsiga_entry.i, id_cnab_mapf: @microsiga_entry.id_cnab_mapf, id_mapfre: @microsiga_entry.id_mapfre, inss: @microsiga_entry.inss, irrf: @microsiga_entry.irrf, iss: @microsiga_entry.iss, j: @microsiga_entry.j, k: @microsiga_entry.k, local_pagto: @microsiga_entry.local_pagto, loja: @microsiga_entry.loja, mod_pagto: @microsiga_entry.mod_pagto, motivo: @microsiga_entry.motivo, mult_natur: @microsiga_entry.mult_natur, n_do_cheque: @microsiga_entry.n_do_cheque, n_etiq_siacc: @microsiga_entry.n_etiq_siacc, natureza: @microsiga_entry.natureza, no_titulo: @microsiga_entry.no_titulo, nom_forn: @microsiga_entry.nom_forn, nr_orig_sisp: @microsiga_entry.nr_orig_sisp, num_liq_sin: @microsiga_entry.num_liq_sin, num_original: @microsiga_entry.num_original, num_remessa: @microsiga_entry.num_remessa, num_sinistro: @microsiga_entry.num_sinistro, parcela: @microsiga_entry.parcela, pis_pasep: @microsiga_entry.pis_pasep, portador: @microsiga_entry.portador, prefixo: @microsiga_entry.prefixo, rateio: @microsiga_entry.rateio, rateio_proj: @microsiga_entry.rateio_proj, rejeitado: @microsiga_entry.rejeitado, status_oper: @microsiga_entry.status_oper, tipo_mapfre: @microsiga_entry.tipo_mapfre, tipo_rubrica: @microsiga_entry.tipo_rubrica, tributo2: @microsiga_entry.tributo2, tributo: @microsiga_entry.tributo, vencimento: @microsiga_entry.vencimento, vencto_real: @microsiga_entry.vencto_real, vida_prev: @microsiga_entry.vida_prev, vl_original: @microsiga_entry.vl_original, vlr_rs: @microsiga_entry.vlr_rs, vlr_titulo: @microsiga_entry.vlr_titulo }
    assert_redirected_to microsiga_entry_path(assigns(:microsiga_entry))
  end

  test "should destroy microsiga_entry" do
    assert_difference('MicrosigaEntry.count', -1) do
      delete :destroy, id: @microsiga_entry
    end

    assert_redirected_to microsiga_entries_path
  end
end
