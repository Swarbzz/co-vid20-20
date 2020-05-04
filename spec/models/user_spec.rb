require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = User.new(email: 'example@example.com',
            password: 'password', password_confirmation: 'password')
  end
  it 'should work with factory bot' do
    user1 = create(:user)
    expect(user1.valid?).to eq(true)
  end
  it 'email should be present' do
   @user.email = ''
   expect(@user.valid?).to eq(false)
  end

  it 'should not accept an invalid email' do
    @user.email = "test.@testingtesting.@.com"
    expect(@user.valid?).to eq(false)
  end

  it 'should have a unique email' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    expect(duplicate_user.valid?).to eq(false)
  end

  it 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'j' * 5
    expect(@user.valid?).to eq(false)
  end

  it 'password should be present' do
    @user.password = @user.password_confirmation = '' * 5
    expect(@user.valid?).to eq(false)
  end
end
