require 'test_helper'

class PlayEntryControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get play_entry_home_url
    assert_response :success
  end

end
