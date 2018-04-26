class EventsController < ApplicationController
  def new
  	@events = Event.all
	@event = Event.new

  end

  def create
	@event = Event.create(new_params)
	@event.name = params[:name]
	@event.date = params[:date]
	# @event.users << params[:user]
	@event.save
	redirect_to root_path
  end

  private

  def new_params
    params.require(:event).permit(:name, :date)
  end

end
