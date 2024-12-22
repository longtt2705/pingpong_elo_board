# frozen_string_literal: true

class MatchHistoriesController < ApplicationController
  before_action :set_match_history, only: %i[show edit update destroy]

  # GET /match_histories or /match_histories.json
  def index
    @match_histories = MatchHistory.all
  end

  # GET /match_histories/1 or /match_histories/1.json
  def show; end

  # GET /match_histories/new
  def new
    @match_history = MatchHistory.new
  end

  # GET /match_histories/1/edit
  def edit; end

  # POST /match_histories or /match_histories.json
  def create
    return render(:edit, status: :unprocessable_entity) if match_history_params[:first_player_points] == match_history_params[:second_player_points]

    first_player = User.find_by(id: match_history_params[:first_player_id])
    second_player = User.find_by(id: match_history_params[:second_player_id])
    winner_id = get_winner_id(first_player.id, second_player.id, match_history_params[:first_player_points],
                              match_history_params[:second_player_points]
    )

    return render(:edit, status: :unprocessable_entity) if first_player.nil? || second_player.nil?

    elo_change = 20
    ApplicationRecord.transaction do
      match_history_data = match_history_params.merge(winner_id: winner_id,
                                                      first_player_elo: first_player.elo,
                                                      second_player_elo: second_player.elo,
                                                      elo_change: elo_change
                                                     )

      @match_history = MatchHistory.new(match_history_data)
      @match_history.save!

      if winner_id == first_player.id
        first_player.elo += elo_change
        second_player.elo -= elo_change
        first_player.win_streak += 1
        second_player.win_streak = 0
      else
        second_player.elo += elo_change
        first_player.elo -= elo_change
        second_player.win_streak += 1
        first_player.win_streak = 0
      end

      first_player_matches = first_player.match_histories
      second_player_matches = second_player.match_histories

      first_player.total_match = first_player_matches.count
      second_player.total_match = second_player_matches.count

      first_player.total_win_match = first_player_matches.count { |match| match.winner_id == first_player.id }
      Rails.logger.debug(first_player.total_win_match)
      second_player.total_win_match = second_player_matches.count { |match| match.winner_id == second_player.id }
      Rails.logger.debug(second_player.total_win_match)

      first_player.save!
      second_player.save!
    end

    redirect_to(root_path)
  rescue StandardError
    render(:edit, status: :unprocessable_entity)
  end

  # PATCH/PUT /match_histories/1 or /match_histories/1.json
  def update
    respond_to do |format|
      if @match_history.update(match_history_params)
        format.html { redirect_to(@match_history, notice: 'Match history was successfully updated.') }
        format.json { render(:show, status: :ok, location: @match_history) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @match_history.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /match_histories/1 or /match_histories/1.json
  def destroy
    @match_history.destroy!

    respond_to do |format|
      format.html { redirect_to(match_histories_path, status: :see_other, notice: 'Match history was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_match_history
    @match_history = MatchHistory.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def match_history_params
    params.require(:match_history).permit(:first_player_id, :second_player_id, :first_player_points, :second_player_points, :first_player_elo,
                                          :second_player_elo, :elo_change, :winner_id
    )
  end

  def get_winner_id(first_player_id, second_player_id, first_player_points, second_player_points)
    return first_player_id if Integer(first_player_points, 10) > Integer(second_player_points, 10)

    second_player_id
  end
end
