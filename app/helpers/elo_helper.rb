# frozen_string_literal: true

module EloHelper
  def elo_rating(winner, loser)
    # Elo rating formula
    # https://en.wikipedia.org/wiki/Elo_rating_system
    # K = 32
    k = 32
    expected = 1.0 / (1.0 + 10.0**((loser - winner) / 400.0))
    Integer(k * (1.0 - expected))
  end
end
