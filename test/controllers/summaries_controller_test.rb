require "test_helper"

class SummariesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get summaries_new_url
    assert_response :success
  end

  test "should get create" do
    get summaries_create_url
    assert_response :success
  end

  test "should get index" do
    get summaries_index_url
    assert_response :success
  end
end
