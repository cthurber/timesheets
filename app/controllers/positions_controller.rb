class PositionsController < ApplicationController
  before_action :authenticate_user!
  # before_action :current_user
  # before_action :set_position, only: [:show, :edit, :update, :destroy]

  def index
     @positions = current_user.positions

  end

  def new
    @position = current_user.positions.new
  end

  def create
    @position= current_user.positions.new(position_params)

    if @position.save
      flash[:success]= "Your position was successfully created"
      redirect_to positions_path
    else
      flash[:error]= "There was an error creating your position"
      render action: :new
  	end
  end

  def edit
    @position = current_user.positions.find(params[:id])
  end

  def update
    @position = current_user.positions.find(params[:id])
  	if @position.update_attributes(position_params)
    		flash[:success] = "Saved position."
    		redirect_to positions_path
  	else
    		flash[:error] = "That position could not be saved."
    		render action: :edit
  	end
  end

  private

    def position_params
      params.require(:position).permit(:employee_id, :job_id, :position_name)
    end

    def set_position
      @position= current_user.positions.find(params[:id])
    end
end
