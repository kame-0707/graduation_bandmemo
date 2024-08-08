require "test_helper"

class PersonalVideosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get personal_videos_index_url
    assert_response :success
  end
end
