class MicrosigaEntriesController < ApplicationController
  before_action :set_microsiga_entry, only: [:show, :edit, :update, :destroy]

  # GET /microsiga_entries
  # GET /microsiga_entries.json
  def index
    @microsiga_entries = MicrosigaEntry.all
  end

  # GET /microsiga_entries/1
  # GET /microsiga_entries/1.json
  def show
  end

  # GET /microsiga_entries/new
  def new
    @microsiga_entry = MicrosigaEntry.new
  end

  # GET /microsiga_entries/1/edit
  def edit
  end

  # POST /microsiga_entries
  # POST /microsiga_entries.json
  def create
    @microsiga_entry = MicrosigaEntry.new(microsiga_entry_params)

    respond_to do |format|
      if @microsiga_entry.save
        format.html { redirect_to @microsiga_entry, notice: 'Microsiga entry was successfully created.' }
        format.json { render :show, status: :created, location: @microsiga_entry }
      else
        format.html { render :new }
        format.json { render json: @microsiga_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /microsiga_entries/1
  # PATCH/PUT /microsiga_entries/1.json
  def update
    respond_to do |format|
      if @microsiga_entry.update(microsiga_entry_params)
        format.html { redirect_to @microsiga_entry, notice: 'Microsiga entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @microsiga_entry }
      else
        format.html { render :edit }
        format.json { render json: @microsiga_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /microsiga_entries/1
  # DELETE /microsiga_entries/1.json
  def destroy
    @microsiga_entry.destroy
    respond_to do |format|
      format.html { redirect_to microsiga_entries_url, notice: 'Microsiga entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_microsiga_entry
      @microsiga_entry = MicrosigaEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def microsiga_entry_params
      params.require(:microsiga_entry).permit(:status_oper, :cnpj_cpf, :tipo_mapfre, :fornecedor, :loja, :nom_forn, :tipo_rubrica, :prefixo, :no_titulo, :parcela, :natureza, :banco_dest, :agencia_dest, :conta_dest, :dt_emissao, :vencimento, :vencto_real, :vlr_titulo, :vl_original, :portador, :iss, :irrf, :inss, :pis_pasep, :cofins, :csll, :n_do_cheque, :historico, :motivo, :rateio, :vlr_rs, :mult_natur, :rateio_proj, :gera_dirf, :mod_pagto, :local_pagto, :cod_agencia, :cod_congener, :cod_pag, :cod_empresa, :cod_corretor, :cod_ramo, :num_liq_sin, :num_sinistro, :num_original, :tributo, :num_remessa, :banco_origem, :ag_origem, :id_cnab_mapf, :id_mapfre, :env_cheque, :enviado, :rejeitado, :dt_import, :dt_exportaca, :boleto, :tributo2, :vida_prev, :dt_ger_pagto, :dt_cancel_ch, :est_enviado, :cheque_pend, :baixa_agluti, :cnpj_2, :data_compens, :conta_origem, :data_exp_rj, :nr_orig_sisp, :n_etiq_siacc, :a, :b, :c, :d, :e, :f, :g, :h, :i, :j, :k)
    end
end
