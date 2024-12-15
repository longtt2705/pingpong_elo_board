json.extract! user, :id, :name, :elo, :win_streak, :total_match, :total_win_match, :created_at, :updated_at
json.url user_url(user, format: :json)
