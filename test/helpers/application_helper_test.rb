require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  setup do
    @desk = desks(:test_desk)
    @grouping = groupings(:grouping1)
    @occupied_desk = desks(:occupied_desk)
    @unoccupied_desk = desks(:unoccupied_desk)
    @w_coordinate = desks(:desk_w_coordinate)
    @wo_coordinate = desks(:desk_wo_coordinate)
  end

  test "#area_tag produces div element" do
    assert_match /^<div[^>]*><\/div>$/,  area_tag(@desk)
  end

  test "#area_tag title is desk title" do
    assert_match /title="#{@desk.name}"/,  area_tag(@desk)
  end

  test "#area_tag type is desk" do
    assert_match /data-type="desk"/, area_tag(@desk)
  end

  test "#area_tag type is grouping" do
    assert_match /data-type="grouping"/, area_tag(@grouping)
  end

  test "#area_tag id is desk's id" do
    assert_match /data-id="#{@desk.id}"/, area_tag(@desk)
  end

  test "#area_tag has class 'occupied' for occupied desk" do
    assert_match /class="[^"]*occupied[^"]*"/, area_tag(@occupied_desk)
  end

  test "#area_tag has class 'free' for free desk" do
    assert_match /class="[^"]*free[^"]*"/, area_tag(@unoccupied_desk)
  end

  test "#area_tag data when coordiante is present" do
    assert_match /data-x="#{@w_coordinate.coordinate.x}"/, area_tag(@w_coordinate)
    assert_match /data-y="#{@w_coordinate.coordinate.y}"/, area_tag(@w_coordinate)
  end

  test "#area_tag data when coordiante is missing" do
    assert_match /data-x="0"/, area_tag(@wo_coordinate)
    assert_match /data-y="0"/, area_tag(@wo_coordinate)
  end

  test "#area_tag style contains transform" do
    assert_match /style="transform: translate\(0px, 0px\)"/, area_tag(@wo_coordinate)
  end
end
