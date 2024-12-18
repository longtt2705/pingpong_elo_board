# frozen_string_literal: true

class MatchHistory < ApplicationRecord
  belongs_to :user

  validates :first_player, :second_player, :first_player_points, :second_player_points, :first_player_elo, :second_player_elo, :elo_change, :winner,
            presence: true
  validates :first_player_points, :second_player_points, :first_player_elo, :second_player_elo, :elo_change,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :winner, inclusion: { in: %w[first_player second_player] }
  validate :first_player_and_second_player_are_different

  private

  def first_player_and_second_player_are_different
    errors.add(:second_player, 'must be different from first player') if first_player == second_player
  end
end
