require 'test_helper'

class QiniuControllerTest < ActionController::TestCase
  test "should get token" do
    get :token
    assert_response :success
  end

end
