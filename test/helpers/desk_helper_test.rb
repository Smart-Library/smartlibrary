require 'test_helper'

class DeskHelperTest < ActionView::TestCase

  setup do
    @occupied_desk = desks :desk1
    @unoccupied_desk = desks :desk2
  end

  test '#desk_status gives correct status' do
    assert_equal desk_status(@occupied_desk), 'Occupied'
    assert_equal desk_status(@unoccupied_desk), 'Not Occupied'
  end

  test '#desk_class gives correct class' do
    assert_equal desk_class(@occupied_desk), 'danger'
    assert_equal desk_class(@unoccupied_desk), 'success'
  end

  test '#desk_element_id gives correct element id' do
    assert_equal desk_element_id(@occupied_desk),
                 "desk_state_#{@occupied_desk.id}"

    assert_equal desk_element_id(@unoccupied_desk),
                 "desk_state_#{@unoccupied_desk.id}"
  end
end