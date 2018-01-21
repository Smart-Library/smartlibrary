require 'test_helper'

class GroupingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @grouping1 = groupings :grouping1
    @grouping2 = groupings :grouping2
    @grouping3 = groupings :grouping3
  end

  test "#index responds with success" do
    get groupings_path

    assert_response :success
  end

  test "#show responds with success" do
    get grouping_path(@grouping1)

    assert_response :success
  end

  test "#new responds with success" do
    get new_grouping_url
    assert_response :success
  end

  test "#create with name and parent" do
    post groupings_url, params: { grouping: { name: 'new', parent_grouping_id: @grouping1.id } }

    grouping = Grouping.last
    assert_equal 'new', grouping.name
    assert_equal @grouping1.id, grouping.parent_grouping_id
  end

  test "#create without parent" do
    post groupings_url, params: { grouping: { name: 'new' } }

    grouping = Grouping.last
    assert_equal 'new', grouping.name
    assert_nil grouping.parent_grouping_id
  end

  test "#create without name" do
    assert_no_difference 'Grouping.count' do
      post groupings_url, params: { grouping: { parent_grouping_id: @grouping1.id } }
    end
  end

  test "#edit responds with success" do
    get edit_grouping_url(@grouping1)
    assert_response :success
  end

  test "#update coordinate already exists" do
    # the desk part of grouping2 already has a coordinate
    assert_update @grouping2
  end

  test "#update coordinate doesn't exist" do
    # the desks and groupings under grouping1 don't have coordinates yet
    assert_update @grouping1
  end

  test "#update with background image" do
    file_name = 'library.jpg'
    content_type = 'image/jpeg'
    img = fixture_file_upload('files/' + file_name, content_type)

    put grouping_url(@grouping2), params: { grouping: { background: img } }
    @grouping2.reload

    assert_equal file_name, @grouping2.background_file_name
    assert_equal content_type, @grouping2.background_content_type
    assert_redirected_to edit_grouping_path(@grouping2)
  end

  test "#update grouping name" do
    new_name = 'some new name'
    put grouping_url(@grouping1), params: { grouping: { name: new_name}}
    @grouping1.reload

    assert_equal new_name, @grouping1.name
  end

  test "#update change grouping parent" do
    put grouping_url(@grouping2), params: { grouping: { parent_grouping_id: @grouping3.id }}
    @grouping2.reload

    assert_equal @grouping3, @grouping2.parent_grouping
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
