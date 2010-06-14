require File.dirname(__FILE__) + '/../test_helper'
require 'expenses_controller'

# Re-raise errors caught by the controller.
class ExpensesController; def rescue_action(e) raise e end; end

class ExpensesControllerTest < Test::Unit::TestCase
  fixtures :expenses

  def setup
    @controller = ExpensesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:expenses)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:expense)
    assert assigns(:expense).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:expense)
  end

  def test_create
    num_expenses = Expense.count

    post :create, :expense => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_expenses + 1, Expense.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:expense)
    assert assigns(:expense).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil Expense.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Expense.find(1)
    }
  end
end
