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

  end

end
