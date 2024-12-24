# frozen_string_literal: true

json.array!(@match_histories, partial: 'match_histories/match_history', as: :match_history)
