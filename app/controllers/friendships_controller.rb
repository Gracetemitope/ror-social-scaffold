class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  # def new
  #   @user = User.new
  #   @friendship = User.new
  # end

  def index
    @friendships = current_user.friend_requests
  end

  def create
    @friendship = Friendship.new(friendship_params) unless check_invitation(current_user,
                                                                            params[:friendship][:invitee_id])

    invitee_path = "/users/#{params[:friendship][:invitee_id]}"

    if @friend_requests.save
      redirect_to invitee_path
      flash[:notice] = 'Friend request sent!'

    else

      flash[:notice] = 'Unable to request friend'

      redirect_to invitee_path

    end
  end

  def update

    @friendship = Friendship.find(params[:id])
    if @friendship.confirm_friend
      redirect_to friendships_path
      flash[:notice] = "You and #{friend_email} are now friends!"

    else

      render friendships_path, confirmed: :unprocessable_entity

    end
  end

  def destroy
    friendship = Friendship.find_by(friendship_params)

    if friendship

      friendship.destroy

      flash[:notice] = 'Request Declined'

    else

      redirect_to friendships_path, alert: 'Please try again.'

    end
  end

  def friendship_params
    params.require(:friendship).permit(:inviter_id, :invitee_id, :confirmed)
  end
end
