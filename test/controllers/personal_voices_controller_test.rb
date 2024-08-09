# frozen_string_literal: true

require 'test_helper'

class PersonalVoicesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get personal_voices_index_url
    assert_response :success
  end
end
