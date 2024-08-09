# frozen_string_literal: true

require 'test_helper'

class PersonalLikesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get personal_likes_index_url
    assert_response :success
  end
end
