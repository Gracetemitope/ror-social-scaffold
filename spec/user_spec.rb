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

  
 
  describe 'associations' do
    before do 
      @user = User.create(name: 'Ifeoluwa', email: 'ife@email.com', password: 'password', gravatar_url: '')
      @user = User.create(name: 'Abiola', email: 'abigold@email.com', password: 'password', gravatar_url: '')

    end
  end

end