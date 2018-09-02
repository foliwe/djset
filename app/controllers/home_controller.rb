class HomeController < ApplicationController
  def index
    @events = Events.all
  end
end
