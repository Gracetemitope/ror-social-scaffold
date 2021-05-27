require 'rails_helper'

RSpec.describe Friendship, type: :model do
  before do
    User.create(name: 'David', email: 'david@email.com', password: 'password', gravatar_url: '')
    User.create(name: 'Blessing', email: 'blessing@email.com', password: 'password', gravatar_url: '')
  end

  let(:inviter) { User.find_by_name('David') }
  let(:invitee) { User.find_by_name('Blessing') }
  let(:incorrect_invitee_user) { User.find_by_name('Temi') }

  context 'with correct params' do
    before do
      @friendship = Friendship.create(inviter_id: inviter.id, invitee_id: invitee.id)
    end

    it 'creates a friendship' do
      expect(@friendship).to be_valid
    end

    it 'reads a friendship' do
      expect(Friendship.find_by(inviter_id: inviter.id)).to eq(@friendship)
    end
  end

  context 'with incorrect params' do
    before do
      allow(incorrect_invitee_user).to receive(:id).and_return('a')
      @friendship = Friendship.create(inviter_id: inviter.id, invitee_id: incorrect_invitee_user.id)
    end

    it 'cannot create a friendship' do
      expect(@friendship).not_to be_valid
    end

    it 'cannot read a friendship' do
      expect(Friendship.find_by(inviter_id: inviter.id)).not_to eq(@friendship)
    end
  end
end
