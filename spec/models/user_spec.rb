require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    context 'user is not valid' do
      it 'is not valid without an email address' do
        user = User.new(password: 'password')
        expect(user).to_not be_valid
      end

      it 'is not valid without a password' do
        user = User.new(email: 'email@email.com')
        expect(user).to_not be_valid
      end

      it 'is not valid if password is too short' do
        user = User.new(email: 'email@email.com', password: 'pass')
        expect(user).to_not be_valid
      end

      it 'is not valid if email is not unique' do
        User.create(email: 'test@test.com', password: 'password')
        user2 = User.new(email: 'test@test.com', password: 'password')

        expect(user2).to_not be_valid
      end
    end

    context 'user is valid' do
      it 'is valid with email and password' do
        user = User.new(email: 'test@test.com', password: 'password')
        expect(user).to be_valid
      end
    end
  end

  describe 'callbacks' do
    context 'after create' do
      it 'creates a blank profile after a user is created' do
        user = User.create(email: 'test@test.com', password: 'password')
        expect(user.profile).to be_present
      end
    end
  end
end
