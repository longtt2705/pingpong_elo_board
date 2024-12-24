# frozen_string_literal: true

require 'application_system_test_case'

class MatchHistoriesTest < ApplicationSystemTestCase
  setup do
    @match_history = match_histories(:one)
  end

  test 'visiting the index' do
    visit match_histories_url
    assert_selector 'h1', text: 'Match histories'
  end

  test 'should create match history' do
    visit match_histories_url
    click_on 'New match history'

    click_on 'Create Match history'

    assert_text 'Match history was successfully created'
    click_on 'Back'
  end

  test 'should update Match history' do
    visit match_history_url(@match_history)
    click_on 'Edit this match history', match: :first

    click_on 'Update Match history'

    assert_text 'Match history was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Match history' do
    visit match_history_url(@match_history)
    click_on 'Destroy this match history', match: :first

    assert_text 'Match history was successfully destroyed'
  end
end
