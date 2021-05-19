require 'rails_helper'

RSpec.describe User, type: :model do
  describe "complete params" do
  before do
    @user = User.create(name: 'David', email: 'david@email.com', password: 'password', gravatar_url: '')
  end
  it 'creates a user' do
    expect(@user).to be_valid
  end

  it 'finds a user' do
    expect(User.find_by(email: 'david@email.com')).to eq(@user)
  end
end
  describe "incomplete params" do

  before do
    @user = User.create( email: 'davi@email.com', password: 'password', gravatar_url: '')
  end

  it 'does not create a user' do
    expect(@user).not_to be_valid
  end

  it ' does not finds a user' do
    expect(User.find_by(name: "David")).not_to eq(@user)
  end
end

  describe 'inviter associations' do
    before do
      @user = User.create(name: 'Ifeoluwa', email: 'ife@email.com', password: 'password', gravatar_url: '')
      @user = User.create(name: 'Abiola', email: 'abigold@email.com', password: 'password', gravatar_url: '')
    end
    let(:inviter) { User.find_by_name('Ifeoluwa') }
    let(:invitee) { User.find_by_name('Abiola') }
    let(:friendship_request) { inviter.friendships.build(invitee_id: invitee.id) }

    it 'can invite another user to be a friend' do
      expect(friendship_request).to be_valid
    end

    it 'can see the name of the invitee' do
      invitee_user = User.find(friendship_request.invitee_id)
      invitee_name = User.find(invitee_user.id).name
      expect(invitee_name).to eq('Abiola')
    end
  end

  describe 'invitee association' do
    before do
      @user = User.create(name: 'Ifeoluwa', email: 'ife@email.com', password: 'password', gravatar_url: '')
      @user = User.create(name: 'Abiola', email: 'abigold@email.com', password: 'password', gravatar_url: '')
    end

    let(:inviter) { User.find_by_name('Ifeoluwa') }
    let(:invitee) { User.find_by_name('Abiola') }
    let(:friendship_request) { inviter.friendships.create(invitee_id: invitee.id) }

    it 'can see the name of the inviter' do
      inviter_user = User.find(friendship_request.inviter_id)
      inviter_user_name = User.find(inviter_user.id).name
      expect(inviter_user_name).to eq('Ifeoluwa')
    end
  end
  end