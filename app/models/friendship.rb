class Friendship < ApplicationRecord
  belongs_to :invitee, class_name: 'User'
  belongs_to :inviter, class_name: 'User'
  scope :comfirmed_friendships, -> { where confirmed: true }

  def confirm_friend
    update_attributes(confirmed: true)
    Friendship.create!(inviter_id: invitee_id,
                       invitee_id: inviter_id, confirmed: true)
  end
end
