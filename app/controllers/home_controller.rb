class HomeController < ApplicationController
  def index
    if request.post?
      render json: params
    else
      render :index
    end
  end
end
