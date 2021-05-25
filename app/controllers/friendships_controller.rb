class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friendships = current_user.friend_requests
  end

  def create
    @friendship = Friendship.new(friendship_params) unless check_invitation(current_user,
                                                                            params[:friendship][:invitee_id])
    invitee_path = "/users/#{params[:friendship][:invitee_id]}"

    if @friendship.save
      flash[:notice] = 'Friend request was sent.'

    else
      flash[:alert] = 'Friend request cannot be sent.'
    end
    redirect_to invitee_path
  end

  def update
    @friendship = Friendship.find(params[:id])

    if @friendship.confirm_friend
      flash[:notice] = 'You have succesfully accepted this request.'
      redirect_to friendships_path
    else
      render friendships_path, status: :unprocessable_entity
    end
  end

  def destroy
    friendship = Friendship.find_by(friendship_params)
    if friendship
      friendship.destroy
      flash[:notice] = 'Friend request was rejected'

    else
      flash[:alert] = 'Please try again.'
    end
    redirect_to friendships_path
  end

  private

  def friendship_params
    params.require(:friendship).permit(:inviter_id, :invitee_id, :confirmed)
  end
end
