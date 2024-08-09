# frozen_string_literal: true

require 'test_helper'

class PersonalSummariesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get personal_summaries_index_url
    assert_response :success
  end
end
