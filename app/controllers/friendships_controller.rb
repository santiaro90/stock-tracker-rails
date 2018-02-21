class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:friend])

    if current_user.friends << friend
      flash[:success] = "#{friend.full_name} was added to your friends"
    else
      flash[:danger] = "The user couldn't be added"
    end

    redirect_to my_friends_path
  end

  def destroy
    friend_id = params[:id]
    friendship = current_user.friendships.where(friend_id: friend_id).first

    friendship.destroy

    flash[:notice] = 'The user was removed from your friends'
    redirect_to my_friends_path
  end
end
