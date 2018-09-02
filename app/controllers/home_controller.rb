class HomeController < ApplicationController
  before_action :get_upcoming_event

  def index
    @events = Event.all
  end

  def get_upcoming_event
    @events = Event.all
    @event = @events.where("start_time >= ?", Time.now).order(start_time: :asc).first
  end
end
