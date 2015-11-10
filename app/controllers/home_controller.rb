class HomeController < ApplicationController
  def index
    @user = User.all
    @pick = Pick.all
  end
end
