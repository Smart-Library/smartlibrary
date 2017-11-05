require 'test_helper'

class DeskTest < ActiveSupport::TestCase
  def setup
    @desk1 = desks :desk1
  end

  test 'valid' do
    assert @desk1.valid?
  end

  test 'invalid without name' do
    @desk1.name = nil
    assert_not @desk1.valid?
    assert @desk1.errors.key? :name
  end

  test 'invalid without grouping' do
    @desk1.grouping = nil
    assert_not @desk1.valid?
    assert @desk1.errors.key? :grouping
  end

  test 'invalid without occupied' do
    @desk1.occupied = nil
    assert_not @desk1.valid?
    assert @desk1.errors.key? :occupied
  end

  test 'belongs to grouping1' do
    assert_equal(groupings(:grouping1), @desk1.grouping)
  end
end
