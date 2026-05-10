class GymsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    
  end

  def show
    
  end

  def create
    @gym = Gym.new(gym_params)

    if @gym.save
      render :create, status: :ok
    else
      render json: { error: @gym.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def gym_params
    params.require(:gym).permit(:name, :address)
  end
end