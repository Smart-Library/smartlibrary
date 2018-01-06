require 'test_helper'

class DeskTest < ActiveSupport::TestCase
  def setup
    @desk1 = desks :test_desk
  end

  test 'valid' do
    assert @desk1.valid?
  end

  test 'valid without grouping' do
    @desk1.grouping = nil
    assert_predicate @desk1, :valid?
  end

  test 'invalid without name' do
    @desk1.name = nil
    refute_predicate @desk1, :valid?
    assert @desk1.errors.key? :name
  end

  test 'occupied defaults to false' do
    desk = Desk.new
    assert_equal(false, desk.occupied)
  end

  test 'belongs to grouping1' do
    assert_equal(groupings(:grouping1), @desk1.grouping)
  end
end
