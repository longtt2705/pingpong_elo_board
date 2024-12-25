# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, uniqueness: true

  def match_histories(limit = nil)
    MatchHistory.where(first_player_id: id).or(MatchHistory.where(second_player_id: id)) if limit.nil?
    MatchHistory.where(first_player_id: id).or(MatchHistory.where(second_player_id: id)).limit(limit)
  end
end
