# frozen_string_literal: true

require 'test_helper'

class MatchHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @match_history = match_histories(:one)
  end

  test 'should get index' do
    get match_histories_url
    assert_response :success
  end

  test 'should get new' do
    get new_match_history_url
    assert_response :success
  end

  test 'should create match_history' do
    assert_difference('MatchHistory.count') do
      post match_histories_url, params: { match_history: {} }
    end

    assert_redirected_to match_history_url(MatchHistory.last)
  end

  test 'should show match_history' do
    get match_history_url(@match_history)
    assert_response :success
  end

  test 'should get edit' do
    get edit_match_history_url(@match_history)
    assert_response :success
  end

  test 'should update match_history' do
    patch match_history_url(@match_history), params: { match_history: {} }
    assert_redirected_to match_history_url(@match_history)
  end

  test 'should destroy match_history' do
    assert_difference('MatchHistory.count', -1) do
      delete match_history_url(@match_history)
    end

    assert_redirected_to match_histories_url
  end
end
