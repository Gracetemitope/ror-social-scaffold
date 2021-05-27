class Friendship < ApplicationRecord
  belongs_to :inviter, class_name: 'User', foreign_key: 'inviter_id'
  belongs_to :invitee, class_name: 'User', foreign_key: 'invitee_id'
  enum confirmed: %i[pending accepted rejected]

  validates_presence_of :inviter, :invitee

  def self.invitee(current_user)
    where(inviter_id: current_user, confirmed: 'accepted').pluck(:invitee_id)
  end

  def self.inviter(current_user)
    where(invitee_id: current_user, confirmed: 'accepted').pluck(:inviter_id)
  end

  def self.friend?(current_user, user)
    friendship = find_by(inviter_id: current_user.id, invitee_id: user.id, confirmed: 'accepted') ||
                 find_by(inviter_id: user.id, invitee_id: current_user.id, confirmed: 'accepted')
    true unless friendship.nil?
  end

  def self.both_sided_friendship(current_user, user)
    find_by(inviter_id: current_user.id,
            invitee_id: user.id) || Friendship.find_by(inviter_id: user.id,
                                                       invitee_id: current_user.id)
  end

  def self.request_sent(current_user, user)
    find_by(inviter_id: user.id, invitee_id: current_user.id, confirmed: 'pending')
  end
end
