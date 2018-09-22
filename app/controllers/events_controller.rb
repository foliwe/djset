class EventsController < ApplicationController
  before_action :set_events_params, only: [:destroy, :edit, :update]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new
    if @event.save
      redirect_to root_path, notice:"the event  #{event.name} has been created"
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def buy
    TicketMailer.email_ticket.deliver
  end

  private

  def set_events_params
    params.require(:event).permit(:name, :address, :start_time, :end_time, :venue)
  end

end
