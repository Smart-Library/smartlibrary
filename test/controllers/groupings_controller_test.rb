require 'test_helper'

class Admin::LayoutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @grouping1 = groupings(:grouping1)
  end

  test "#show responds with success" do
    get grouping_path(@grouping1)

    assert_response :success
  end
end
