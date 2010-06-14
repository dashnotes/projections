require File.dirname(__FILE__) + '/../test_helper'

class ProjectionTest < Test::Unit::TestCase
  fixtures :projections

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Projection, projections(:first)
  end
end
