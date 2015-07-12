require 'test_helper'

class ExtractsControllerTest < ActionController::TestCase
  setup do
    @extract = extracts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:extracts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create extract" do
    assert_difference('Extract.count') do
      post :create, extract: { account: @extract.account, alloc_date: @extract.alloc_date, alloc_ind: @extract.alloc_ind, alloc_period: @extract.alloc_period, alloc_ref: @extract.alloc_ref, amend_op: @extract.amend_op, asset_code: @extract.asset_code, asset_indicator: @extract.asset_indicator, asset_subcode: @extract.asset_subcode, base_amt: @extract.base_amt, conversion_code: @extract.conversion_code, debit_credit_marker: @extract.debit_credit_marker, description: @extract.description, due_date: @extract.due_date, entry_date: @extract.entry_date, entry_op: @extract.entry_op, entry_period: @extract.entry_period, journal: @extract.journal, journal_source: @extract.journal_source, journal_type: @extract.journal_type, ledger: @extract.ledger, line_no: @extract.line_no, other_amt: @extract.other_amt, period: @extract.period, post_op: @extract.post_op, rate: @extract.rate, reference: @extract.reference, rough_book: @extract.rough_book, signal_base_amt: @extract.signal_base_amt, signal_other_amt: @extract.signal_other_amt, tcode_0: @extract.tcode_0, tcode_1: @extract.tcode_1, tcode_2: @extract.tcode_2, tcode_3: @extract.tcode_3, tcode_4: @extract.tcode_4, tcode_5: @extract.tcode_5, tcode_6: @extract.tcode_6, tcode_7: @extract.tcode_7, tcode_8: @extract.tcode_8, tcode_9: @extract.tcode_9, transaction_date: @extract.transaction_date }
    end

    assert_redirected_to extract_path(assigns(:extract))
  end

  test "should show extract" do
    get :show, id: @extract
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @extract
    assert_response :success
  end

  test "should update extract" do
    patch :update, id: @extract, extract: { account: @extract.account, alloc_date: @extract.alloc_date, alloc_ind: @extract.alloc_ind, alloc_period: @extract.alloc_period, alloc_ref: @extract.alloc_ref, amend_op: @extract.amend_op, asset_code: @extract.asset_code, asset_indicator: @extract.asset_indicator, asset_subcode: @extract.asset_subcode, base_amt: @extract.base_amt, conversion_code: @extract.conversion_code, debit_credit_marker: @extract.debit_credit_marker, description: @extract.description, due_date: @extract.due_date, entry_date: @extract.entry_date, entry_op: @extract.entry_op, entry_period: @extract.entry_period, journal: @extract.journal, journal_source: @extract.journal_source, journal_type: @extract.journal_type, ledger: @extract.ledger, line_no: @extract.line_no, other_amt: @extract.other_amt, period: @extract.period, post_op: @extract.post_op, rate: @extract.rate, reference: @extract.reference, rough_book: @extract.rough_book, signal_base_amt: @extract.signal_base_amt, signal_other_amt: @extract.signal_other_amt, tcode_0: @extract.tcode_0, tcode_1: @extract.tcode_1, tcode_2: @extract.tcode_2, tcode_3: @extract.tcode_3, tcode_4: @extract.tcode_4, tcode_5: @extract.tcode_5, tcode_6: @extract.tcode_6, tcode_7: @extract.tcode_7, tcode_8: @extract.tcode_8, tcode_9: @extract.tcode_9, transaction_date: @extract.transaction_date }
    assert_redirected_to extract_path(assigns(:extract))
  end

  test "should destroy extract" do
    assert_difference('Extract.count', -1) do
      delete :destroy, id: @extract
    end

    assert_redirected_to extracts_path
  end
end
