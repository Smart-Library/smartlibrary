require 'test_helper'

class DesksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @desk1 = desks :desk1
  end

  test "#index responds all the desks" do
    get desks_path

    assert_response :success
  end

  test "#create responds with json format" do
    post desks_path, params: { desk: { name: @desk1.name } }

    assert_equal "application/json", response.content_type
  end

  test "#create responds with 200 if params are valid" do
    post desks_path, params: { desk: { name: @desk1.name } }

    assert_response :success
  end

  test "#create responds with 422 if name is null" do
    post desks_path, params: { desk: { name: nil } }

    assert_response :unprocessable_entity
  end

  test "#show responds with desk" do
    get desk_path(id: 1)

    assert_response :success
    assert_template 'show'
  end

  test "#show responds with desk in json format" do
    get desk_path(id: 1, format: :json)

    assert_response :success
    assert_equal @desk1.to_json, response.body
  end

  test "#update updates desk and responds with updated desk" do
    put desk_path(id: 1), params: { desk: { occupied: false } }

    assert_response :success
    assert_equal false, JSON.parse(response.body)["occupied"]
  end

  test "#update responds with 422 if occupied is attribute is null" do
    put desk_path(id: 1), params: { desk: { name: nil } }

    assert_response :unprocessable_entity
  end
end
