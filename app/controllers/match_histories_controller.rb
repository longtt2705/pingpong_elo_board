class MatchHistoriesController < ApplicationController
  before_action :set_match_history, only: %i[ show edit update destroy ]

  # GET /match_histories or /match_histories.json
  def index
    @match_histories = MatchHistory.all
  end

  # GET /match_histories/1 or /match_histories/1.json
  def show
  end

  # GET /match_histories/new
  def new
    @match_history = MatchHistory.new
  end

  # GET /match_histories/1/edit
  def edit
  end

  # POST /match_histories or /match_histories.json
  def create
    @match_history = MatchHistory.new(match_history_params)

    respond_to do |format|
      if @match_history.save
        format.html { redirect_to @match_history, notice: "Match history was successfully created." }
        format.json { render :show, status: :created, location: @match_history }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @match_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /match_histories/1 or /match_histories/1.json
  def update
    respond_to do |format|
      if @match_history.update(match_history_params)
        format.html { redirect_to @match_history, notice: "Match history was successfully updated." }
        format.json { render :show, status: :ok, location: @match_history }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @match_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /match_histories/1 or /match_histories/1.json
  def destroy
    @match_history.destroy!

    respond_to do |format|
      format.html { redirect_to match_histories_path, status: :see_other, notice: "Match history was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match_history
      @match_history = MatchHistory.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def match_history_params
      params.fetch(:match_history, {})
    end
end
