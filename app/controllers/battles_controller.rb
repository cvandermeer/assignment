class BattlesController < ApplicationController
  before_action :set_battle, only: %i[show escape capture]

  def index
    @battles = Battle.all
  end

  def new
    @opponent = Pokemon.find_by(id: params[:opponent_id])

    @battle = Battle.new(
      battle_type: params.fetch(:battle_type, "encounter"),
      opponent: @opponent,
      trainer: current_trainer
    )
  end

  def create
    @battle = Battle.new(battle_params)

    if @battle.save
      redirect_to battle_path(@battle)
    else
      redirect_to new_battle_path(battle_params)
    end
  end

  def show
  end

  def escape
    @battle.escape!
    redirect_to battle_path(@battle)
  end

  def capture
    @battle.capture!
    redirect_to battle_path(@battle)
  end

  private

  def set_battle
    @battle = Battle.find(params[:id])
  end

  def battle_params
    params.
      require(:battle).
      permit(
        :battle_type,
        :opponent_id,
        :trainer_id
      )
  end
end