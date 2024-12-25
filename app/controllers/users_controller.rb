# frozen_string_literal: true

class UsersController < ApplicationController
  include UsersHelper
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users or /users.json
  def index
    redirect_to(root_path)
  end

  # GET /users/1 or /users/1.json
  def show
    user = User.find(params.expect(:id))
    total_users = User.count
    index = User.all.order(elo: :desc).index(user)

    @aggregate_user = user_info(user, index, total_users)
    @recent_matches = @user.match_histories(20)

    recently_played_hash = {}
    @recent_matches.each do |match|
      opponent = match.first_player_id == user.id ? match.second_player : match.first_player
      is_win = match.winner_id == user.id
      if recently_played_hash[opponent.id].nil?
        recently_played_hash[opponent.id] = { user: opponent, total_played: 1, wins: is_win ? 1 : 0 }
      else
        recently_played_hash[opponent.id][:total_played] += 1
        recently_played_hash[opponent.id][:wins] += 1 if is_win
      end
    end

    @recently_played = recently_played_hash.values
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to(root_path, notice: 'User was successfully created.') }
        format.json { render(:show, status: :created, location: @user) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @user.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to(@user, notice: 'User was successfully updated.') }
        format.json { render(:show, status: :ok, location: @user) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @user.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to(users_path, status: :see_other, notice: 'User was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.expect(user: %i[name elo win_streak total_match total_win_match])
  end
end
