require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Validations" do

    it 'should validate all fields' do
      new_user = User.new first_name: 'Bob', last_name: 'Burger', email: 'bob@gmail.com', password: '12345', password_confirmation: '12345'
      expect(new_user.save).to eq(true)
    end

    it 'should not validate if both passwords do not match' do
      new_user = User.new first_name: 'Bob', last_name: 'Burger', email: 'bob@gmail.com', password: '12345', password_confirmation: '54321'
      new_user.save
      expect(new_user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should not validate if the email is already in the database' do
      old_user = User.new first_name: 'Bob', last_name: 'Cousin', email: 'BOB@gmail.com', password: '12345', password_confirmation: '12345'
      old_user.save

      new_user = User.new first_name: 'Bob', last_name: 'Burger', email: 'bob@gmail.com', password: '12345', password_confirmation: '12345'
      new_user.save

      expect(new_user.errors.full_messages).to include("Email has already been taken")
    end

    it 'should not validate if the password is too short' do
      new_user = User.new first_name: 'Bob', last_name: 'Burger', email: 'bob@gmail.com', password: '123', password_confirmation: '123'
      new_user.save
      expect(new_user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end

  end

  describe '.authenticate_with_credentials' do
    it 'should authenticate an email with the correct email and password' do
      new_user = User.new first_name: 'Bob', last_name: 'Burger', email: 'bob@gmail.com', password: '12345', password_confirmation: '12345'
      new_user.save
      expect(new_user = User.authenticate_with_credentials('bob@gmail.com', '12345')).to_not be(nil)
    end

    it 'should not create a session if the email doesnt exist in the database' do
      new_user = User.new first_name: 'Bob', last_name: 'Burger', email: 'bob@gmail.com', password: '12345', password_confirmation: '12345'
      new_user.save
      expect(new_user = User.authenticate_with_credentials('notbob@gmail.com', '12345')).to be(nil)
    end

    it 'should not create a session if the password doesnt match' do
      new_user = User.new first_name: 'Bob', last_name: 'Burger', email: 'bob@gmail.com', password: '12345', password_confirmation: '12345'
      new_user.save
      expect(new_user = User.authenticate_with_credentials('bob@gmail.com', '54321')).to be(nil)
    end

    it 'should create a session if the email was input with spaces on either side of it' do
      new_user = User.new first_name: 'Bob', last_name: 'Burger', email: 'bob@gmail.com', password: '12345', password_confirmation: '12345'
      new_user.save
      expect(new_user = User.authenticate_with_credentials('       bob@gmail.com    ', '12345')).to_not be(nil)
    end

    it 'should create a session if the email was input with a different case' do
      new_user = User.new first_name: 'Bob', last_name: 'Burger', email: 'bob@gmail.com', password: '12345', password_confirmation: '12345'
      new_user.save
      expect(new_user = User.authenticate_with_credentials('BOB@GMAIL.com', '12345')).to_not be(nil)
    end

  end

end
