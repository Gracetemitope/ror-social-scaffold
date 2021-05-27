module UsersHelper
  # rubocop:disable Style/GuardClause

  def friend_button(current_user, user)
    'You are friends' if Friendship.friend?(current_user, user)
  end

  def friend_post(current_user, user)
    if Friendship.friend?(current_user, user)
      render @posts
    else
      render @other_posts
    end
  end

  def friendship_button(current_user, user)
    friendship = Friendship.both_sided_friendship(current_user, user)
    pending_request = Friendship.request_sent(current_user, user)
    if (friendship.nil? or friendship[:confirmed] == 'rejected') and current_user != user and !pending_request
      button_to 'Invite to friendship', user_friendships_path(user[:id]),
                params: { friendship: { invitee_id: user.id } }
    end
  end

  def friendship_update_button(current_user, user)
    pending_request = Friendship.request_sent(current_user, user)
    if current_user != user and pending_request
      concat button_to 'Accept', update_friendship_path(current_user[:id], pending_request[:id]),
                       params: { friendship: { id: pending_request[:id] } },
                       method: :patch
      button_to 'Reject', delete_friendship_path(current_user[:id], pending_request[:id]),
                params: { friendship: { id: pending_request[:id] } }, confirmed: 'rejected',
                method: :delete
    end
  end
  # rubocop:enable Style/GuardClause
end
