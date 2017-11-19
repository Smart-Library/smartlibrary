require 'test_helper'

class DesksControllerTest < ActionDispatch::IntegrationTest
  include ActionCable::TestHelper

  setup do
    @desk = desks(:desk1)
  end

  test "#index responds with all the desks" do
    get desks_path

    assert_response :success
  end

  test "#create responds with 200 if params are valid" do
    post desks_path(format: :json), params: { desk: { name: 'test desk' } }

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    refute_nil parsed_response[:id]
    assert_equal 'test desk', parsed_response[:name]
  end

  test "#create responds with 422 if name is null" do
    post desks_path, params: { desk: { name: nil } }

    assert_response :unprocessable_entity
  end

  test "#show responds with desk" do
    get desk_path(@desk)

    assert_response :success
    assert_template 'show'
  end

  test "#show responds with desk in json format" do
    get desk_path(@desk, format: :json)

    assert_response :success
    assert_equal @desk.to_json, response.body
  end

  test "#update updates desk and responds with updated desk" do
    put desk_path(@desk, format: :json), params: { desk: { occupied: !@desk.occupied } }

    assert_broadcast_on('desks', id: @desk.id, name: @desk.name, occupied: !@desk.occupied)
    assert_response 204
  end

  test "#update doesn't broadcast when occupied attribute remains unchanged" do
    put desk_path(@desk, format: :json), params: { desk: { occupied: @desk.occupied } }

    assert_no_broadcasts('desks')
    assert_response 204
  end

  test "#update responds with 422 if occupied is attribute is null" do
    put desk_path(@desk, format: :json), params: { desk: { name: nil } }

    assert_no_broadcasts 'desk'
    assert_response :unprocessable_entity
  end
end
