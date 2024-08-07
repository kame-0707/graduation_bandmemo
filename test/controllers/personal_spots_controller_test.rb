require "test_helper"

class PersonalSpotsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get personal_spots_index_url
    assert_response :success
  end
end
