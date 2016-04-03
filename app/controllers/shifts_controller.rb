class ShiftsController < ApplicationController

  before_filter :get_position

  def get_position
    @position = Position.find(params[:position_id])

  end

  def index
     @shifts = @position.shifts

  end

  def new
    @shift = @position.shifts.new
  end

  def create
    @shift= @position.shifts.new(shift_params)

    if @shift.save
      flash[:success]= "Your shift was successfully created"
      redirect_to positions_path
    else
      flash[:error]= "There was an error creating your shift"
      render action: :new
  	end
  end

  def edit
    # @shift = @position.shifts.find(params[:shift_id])
    @shift = @position.shifts.find(params[:id])
  end

  def update
    @shift = @position.shifts.find(params[:id])
  	if @shift.update_attributes(shift_params)
    		flash[:success] = "Saved shift."
    		redirect_to positions_path
  	else
    		flash[:error] = "That shift could not be saved."
    		render action: :edit
  	end
  end

  private

    def shift_params
      params.require(:shift).permit(:shift_number, :day_of_week, :start_time, :end_time)
    end


end
