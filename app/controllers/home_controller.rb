# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    users = User.all.order(elo: :desc)
    total_users = users.count
    @aggregate_users = users.each_with_index.map do |user, index|
      tier = calculate_tier(index, total_users)
      {
        user: user,
        tier: tier,
        wins: user.total_win_match || 0,
        losses: (user.total_match || 0) - (user.total_win_match || 0),
        win_rate: (Float(user.total_win_match) / Float(user.total_match) * 100).round(2),
        flame_icon: get_flame_icon(user.win_streak)
      }
    end
  end

  private

  def get_flame_icon(win_streak)
    case win_streak
    when 0..2
      'flame-0.png'
    when 2..5
      'flame-1.png'
    else
      'flame-2.png'
    end
  end

  def calculate_tier(index, total_user)
    case index
    when 0..(total_user * 0.05)
      'Challenger'
    when (total_user * 0.05)..(total_user * 0.15)
      'Grandmaster'
    when (total_user * 0.15)..(total_user * 0.3)
      'Master'
    when (total_user * 0.3)..(total_user * 0.4)
      'Diamond'
    when (total_user * 0.4)..(total_user * 0.5)
      'Emerald'
    when (total_user * 0.5)..(total_user * 0.6)
      'Platinum'
    when (total_user * 0.6)..(total_user * 0.7)
      'Gold'
    when (total_user * 0.7)..(total_user * 0.8)
      'Silver'
    when (total_user * 0.8)..(total_user * 0.9)
      'Bronze'
    else
      'Iron'
    end
  end
end
