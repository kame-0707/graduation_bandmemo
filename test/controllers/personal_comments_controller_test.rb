# frozen_string_literal: true

require 'test_helper'

class PersonalCommentsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get personal_comments_index_url
    assert_response :success
  end
end
