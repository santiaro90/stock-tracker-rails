class UsersController < ApplicationController
  def my_friends
    @friendships = current_user.friends
  end

  def my_portfolio
    @user = current_user
    @stocks = current_user.stocks
  end

  def search
    if params[:search].blank?
      flash.now[:danger] = 'Enter something to search for'
    else
      @users = User.search(params[:search]) - [current_user]
      flash.now[:danger] = 'No results found' if @users.empty?
    end

    render partial: 'friends/lookup_results'
  end
end
