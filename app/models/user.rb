# frozen_string_literal: true

class User < ApplicationRecord
  has_many :match_histories, dependent: :destroy
  validates :name, uniqueness: true
end
