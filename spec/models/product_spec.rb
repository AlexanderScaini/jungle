require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should validate all fields' do
      @category = Category.new name: 'Pipes'
      new_product = Product.new name: 'Lemon', price: 2000, quantity: 30, category: @category
      expect(new_product.save).to eq(true)
    end

    it 'should validate name' do
      @category = Category.new name: 'Pipes'
      new_product = Product.new name: nil, price: 2000, quantity: 30, category: @category
      new_product.save
      expect(new_product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should validate price' do
      @category = Category.new name: 'Pipes'
      new_product = Product.new name: 'Lemon', price: nil, quantity: 30, category: @category
      new_product.save
      expect(new_product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should validate quantity' do
      @category = Category.new name: 'Pipes'
      new_product = Product.new name: 'Lemon', price: 2000, quantity: nil, category: @category
      new_product.save
      expect(new_product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should validate category' do
      @category = Category.new name: 'Pipes'
      new_product = Product.new name: 'Lemon', price: 2000, quantity: 30, category: nil
      new_product.save
      expect(new_product.errors.full_messages).to include("Category can't be blank")
    end
  end
end

