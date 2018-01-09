require 'test_helper'

class GroupingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @grouping1 = groupings(:grouping1)
    @grouping2 = groupings :grouping2
  end

  test "#show responds with success" do
    get grouping_path(@grouping1)

    assert_response :success
  end

  test '#edit responds with success' do
    get edit_grouping_url(@grouping1)
    assert_response :success
  end

  test '#update coordinate already exists' do
    # the desk part of grouping2 already has a coordinate
    assert_update @grouping2
  end

  test '#update coordinate does not exist' do
    # the desks and groupings under grouping1 don't have coordinates yet
    assert_update @grouping1
  end

  private

  def assert_update(grouping)
    desk_json = coordinate_json(grouping.desks)
    grouping_json = coordinate_json(grouping.child_groupings)
    # generate mock layout param from client for updating coordinates
    params = { layout: { desk: desk_json, grouping: grouping_json }.to_json }

    put grouping_url(grouping), params: params
    # get updated grouping from db
    grouping = Grouping.find(grouping.id)

    # assert coordinates have been properly updated
    assert_coordinate grouping.desks, desk_json
    assert_coordinate grouping.child_groupings, grouping_json
    assert_redirected_to edit_grouping_path(grouping)
  end

  def assert_coordinate(elems, coordinates)
    elems.each do |e|
      assert_in_delta coordinates[e.id.to_s]['x'], e.coordinate.x, 1.0e-15
      assert_in_delta coordinates[e.id.to_s]['y'], e.coordinate.y, 1.0e-15
    end
  end

  def coordinate_json(elems)
    elems.each_with_object({}) do |e, h|
      h[e.id.to_s] = { 'x' => rand(), 'y' => rand() }
    end
  end
end
