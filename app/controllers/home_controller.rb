# frozen_string_literal: true

class HomeController < ApplicationController
  include UsersHelper
  def index
    users = User.all.order(elo: :desc)
    total_users = users.count
    @aggregate_users = users.each_with_index.map do |user, index|
      user_info(user, index, total_users)
    end
  end
end
