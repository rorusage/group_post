class WelcomeController < ApplicationController
  def index
    flash[:info] = "資訊"
  end
end
