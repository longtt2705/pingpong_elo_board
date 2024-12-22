# frozen_string_literal: true

class MatchHistory < ApplicationRecord
  include EloHelper

  belongs_to :first_player, class_name: 'User'
  belongs_to :second_player, class_name: 'User'
  belongs_to :winner, class_name: 'User'

  validates :first_player, :second_player, :first_player_points, :second_player_points, :first_player_elo, :second_player_elo, :elo_change, :winner,
            presence: true
  validates :first_player_points, :second_player_points, :first_player_elo, :second_player_elo, :elo_change,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :winner, inclusion: { in: -> (match) { [match.first_player, match.second_player] } }
  validate :first_player_and_second_player_are_different

  after_create :update_users_data

  private

  def first_player_and_second_player_are_different
    errors.add(:second_player, 'must be different from first player') if first_player == second_player
  end

  def update_users_data
    winner.win_streak += 1
    winner.total_match += 1

    loser = [first_player, second_player].find { |player| player != winner }
    loser.win_streak = 0
    loser.total_match += 1

    elo_change = EloHelper.elo_rating(first_player_elo, second_player_elo)
    winner.elo += elo_change
    loser.elo -= elo_change

    loser.save!
    winner.save!
  end
end
