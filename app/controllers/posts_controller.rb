class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    timeline_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def timeline_posts
    @invitee_friends = Friendship.where(inviter_id: current_user, confirmed: 'accepted').pluck(:invitee_id)
    @inviter_friends = Friendship.where(invitee_id: current_user, confirmed: 'accepted').pluck(:inviter_id)
    @user_and_friends = @invitee_friends + @inviter_friends + [current_user[:id]]
    @timeline_posts ||= Post.where(user_id: @user_and_friends).ordered_by_most_recent.includes(:user)
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
