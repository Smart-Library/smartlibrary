require 'test_helper'

class DeskTest < ActiveSupport::TestCase
  def setup
    @desk1 = desks :desk1
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

  test '#relevant_changes no changes' do
    @desk1.update(@desk1.slice('name'))
    assert_equal @desk1.slice('id'), @desk1.relevant_changes
  end

  test '#relevant_changes changed occupied' do
    @desk1.update(occupied: !@desk1.occupied)
    assert_equal @desk1.slice('id', 'occupied'), @desk1.relevant_changes
  end

  test '#relevant_changes changed name' do
    @desk1.update(name: 'blahblah')
    assert_equal @desk1.slice('id', 'name'), @desk1.relevant_changes
  end
end
