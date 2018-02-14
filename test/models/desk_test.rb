require 'test_helper'

class DeskTest < ActiveSupport::TestCase
  include ActionCable::TestHelper

  setup do
    @desk1 = desks :test_desk
  end

  test "valid" do
    assert @desk1.valid?
  end

  test "valid without grouping" do
    @desk1.grouping = nil
    assert_predicate @desk1, :valid?
  end

  test "invalid without name" do
    @desk1.name = nil
    refute_predicate @desk1, :valid?
    assert @desk1.errors.key? :name
  end

  test "occupied defaults to false" do
    desk = Desk.new
    assert_equal(false, desk.occupied)
  end

  test "belongs to grouping1" do
    assert_equal(groupings(:grouping1), @desk1.grouping)
  end

  test "broadcast when change to occupied" do
    status = @desk1.occupied?
    @desk1.update(occupied: !status)

    assert_broadcast_on 'desks', desk_info: { id: @desk1.id, occupied: !status }
  end

  test "no broadcast when no change to occupied" do
    @desk1.update(occupied: @desk1.occupied?)

    assert_no_broadcasts 'desks'
  end

  test "no broadcast when change to name" do
    @desk1.update(name: 'Random new name')

    assert_no_broadcasts 'desks'
  end
end
