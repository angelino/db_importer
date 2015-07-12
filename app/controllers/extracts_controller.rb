class ExtractsController < ApplicationController
  before_action :set_extract, only: [:show, :edit, :update, :destroy]

  # GET /extracts
  # GET /extracts.json
  def index
    @extracts = Extract.paginate(:page => params[:page], :per_page => 50)
  end

  # GET /extracts/1
  # GET /extracts/1.json
  def show
  end

  # GET /extracts/new
  def new
    @extract = Extract.new
  end

  # GET /extracts/1/edit
  def edit
  end

  # POST /extracts
  # POST /extracts.json
  def create
    @extract = Extract.new(extract_params)

    respond_to do |format|
      if @extract.save
        format.html { redirect_to @extract, notice: 'Extract was successfully created.' }
        format.json { render :show, status: :created, location: @extract }
      else
        format.html { render :new }
        format.json { render json: @extract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /extracts/1
  # PATCH/PUT /extracts/1.json
  def update
    respond_to do |format|
      if @extract.update(extract_params)
        format.html { redirect_to @extract, notice: 'Extract was successfully updated.' }
        format.json { render :show, status: :ok, location: @extract }
      else
        format.html { render :edit }
        format.json { render json: @extract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /extracts/1
  # DELETE /extracts/1.json
  def destroy
    @extract.destroy
    respond_to do |format|
      format.html { redirect_to extracts_url, notice: 'Extract was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_extract
      @extract = Extract.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def extract_params
      params.require(:extract).permit(:ledger, :account, :period, :transaction_date, :journal, :line_no, :base_amt, :signal_base_amt, :debit_credit_marker, :reference, :description, :journal_type, :journal_source, :other_amt, :signal_other_amt, :conversion_code, :rate, :tcode_0, :tcode_1, :tcode_2, :tcode_3, :tcode_4, :tcode_5, :tcode_6, :tcode_7, :tcode_8, :tcode_9, :alloc_ind, :alloc_ref, :alloc_period, :alloc_date, :asset_indicator, :asset_code, :asset_subcode, :entry_date, :entry_period, :due_date, :entry_op, :post_op, :amend_op, :rough_book)
    end
end
