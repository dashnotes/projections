require File.dirname(__FILE__) + '/../test_helper'

class ExpenseTest < Test::Unit::TestCase
  fixtures :expenses

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Expense, expenses(:first)
  end
end
