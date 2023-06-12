class UserController < ApplicationController

  def index
  end

  def create
    friend_id = params[:user]
    user = current_user

    debugger
    friend = Friendship.new(user_id: user.id, friend_id: friend_id)
    if friend.save
      flash[:notice] = "Added friend"
      redirect_to my_friends_path
    else
      flash[:alert] = "Friend addition unsucessful"
      redirect_to my_friends_path
    end
  end

  def destroy
    friend_id = params[:id]
    user = current_user.id

    Friendship.where(user_id: user, friend_id: friend_id).first.destroy
    flash[:alert] = "Friend has been removed"
    redirect_to my_friends_path
  end

  def search
    @users = User.all
  end
end