class HomesController < ApplicationController
  def index
    redirect_to about_homes_path unless user_signed_in?
  end
  def about
  end
  def logout
  end
end
