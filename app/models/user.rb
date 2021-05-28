class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, foreign_key: :inviter_id, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :invitee_id, dependent: :destroy

  has_many :pending_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendships, source: :friend

  has_many :check_friends, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :friends, through: :check_friends, source: :friend
end
