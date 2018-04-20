class HomeController < ApplicationController
  def index
  end

  def new
  	redirect_to events_new_path
  end
end
