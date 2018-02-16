class UsersController < ApplicationController
  def my_portfolio
    @user = current_user
    @stocks = current_user.stocks
  end
end
