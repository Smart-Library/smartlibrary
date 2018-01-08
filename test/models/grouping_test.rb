require 'test_helper'

class GroupingTest < ActiveSupport::TestCase
  def setup
    @grouping1 = groupings :grouping1
    @grouping2 = groupings :grouping2
  end

  test 'valid without parent' do
    assert @grouping1.valid?
  end

  test 'valid with parent' do
    assert @grouping2.valid?
  end

  test 'invalid without name' do
    @grouping1.name = nil
    refute_predicate @grouping1, :valid?
    assert @grouping1.errors.messages.key? :name
  end

  test 'grouping2 belongs to grouping1' do
    assert_equal(@grouping1, @grouping2.parent_grouping)
  end

  test 'grouping1 has grouping2' do
    assert_equal(@grouping2, @grouping1.child_groupings.first)
  end

  test 'grouping1 has desk1' do
    assert_equal(desks(:test_desk), @grouping1.desks.first)
  end

  test '#children returns array of desks and groupings inside the grouping' do
    assert_equal @grouping1.desks + @grouping1.child_groupings, @grouping1.children
  end
end
