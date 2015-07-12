require 'test_helper'

class LedgersControllerTest < ActionController::TestCase
  setup do
    @ledger = ledgers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ledgers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ledger" do
    assert_difference('Ledger.count') do
      post :create, ledger: { account: @ledger.account, alloc_date: @ledger.alloc_date, alloc_ind: @ledger.alloc_ind, alloc_period: @ledger.alloc_period, alloc_ref: @ledger.alloc_ref, amend_op: @ledger.amend_op, asset_code: @ledger.asset_code, asset_indicator: @ledger.asset_indicator, asset_subcode: @ledger.asset_subcode, base_amt: @ledger.base_amt, conversion_code: @ledger.conversion_code, debit_credit_marker: @ledger.debit_credit_marker, description: @ledger.description, due_date: @ledger.due_date, entry_date: @ledger.entry_date, entry_op: @ledger.entry_op, entry_period: @ledger.entry_period, journal: @ledger.journal, journal_source: @ledger.journal_source, journal_type: @ledger.journal_type, ledger: @ledger.ledger, line_no: @ledger.line_no, other_amt: @ledger.other_amt, period: @ledger.period, post_op: @ledger.post_op, rate: @ledger.rate, reference: @ledger.reference, rough_book: @ledger.rough_book, signal_base_amt: @ledger.signal_base_amt, signal_other_amt: @ledger.signal_other_amt, tcode_0: @ledger.tcode_0, tcode_1: @ledger.tcode_1, tcode_2: @ledger.tcode_2, tcode_3: @ledger.tcode_3, tcode_4: @ledger.tcode_4, tcode_5: @ledger.tcode_5, tcode_6: @ledger.tcode_6, tcode_7: @ledger.tcode_7, tcode_8: @ledger.tcode_8, tcode_9: @ledger.tcode_9, transaction_date: @ledger.transaction_date }
    end

    assert_redirected_to ledger_path(assigns(:ledger))
  end

  test "should show ledger" do
    get :show, id: @ledger
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ledger
    assert_response :success
  end

  test "should update ledger" do
    patch :update, id: @ledger, ledger: { account: @ledger.account, alloc_date: @ledger.alloc_date, alloc_ind: @ledger.alloc_ind, alloc_period: @ledger.alloc_period, alloc_ref: @ledger.alloc_ref, amend_op: @ledger.amend_op, asset_code: @ledger.asset_code, asset_indicator: @ledger.asset_indicator, asset_subcode: @ledger.asset_subcode, base_amt: @ledger.base_amt, conversion_code: @ledger.conversion_code, debit_credit_marker: @ledger.debit_credit_marker, description: @ledger.description, due_date: @ledger.due_date, entry_date: @ledger.entry_date, entry_op: @ledger.entry_op, entry_period: @ledger.entry_period, journal: @ledger.journal, journal_source: @ledger.journal_source, journal_type: @ledger.journal_type, ledger: @ledger.ledger, line_no: @ledger.line_no, other_amt: @ledger.other_amt, period: @ledger.period, post_op: @ledger.post_op, rate: @ledger.rate, reference: @ledger.reference, rough_book: @ledger.rough_book, signal_base_amt: @ledger.signal_base_amt, signal_other_amt: @ledger.signal_other_amt, tcode_0: @ledger.tcode_0, tcode_1: @ledger.tcode_1, tcode_2: @ledger.tcode_2, tcode_3: @ledger.tcode_3, tcode_4: @ledger.tcode_4, tcode_5: @ledger.tcode_5, tcode_6: @ledger.tcode_6, tcode_7: @ledger.tcode_7, tcode_8: @ledger.tcode_8, tcode_9: @ledger.tcode_9, transaction_date: @ledger.transaction_date }
    assert_redirected_to ledger_path(assigns(:ledger))
  end

  test "should destroy ledger" do
    assert_difference('Ledger.count', -1) do
      delete :destroy, id: @ledger
    end

    assert_redirected_to ledgers_path
  end
end
