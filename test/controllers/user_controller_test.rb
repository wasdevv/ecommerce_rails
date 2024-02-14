require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get admin_user" do
    get user_admin_user_url
    assert_response :success
  end
end
