class HomeController < ApplicationController
  def index
  end

  def new
  	redirect_to create_path
  end
end
