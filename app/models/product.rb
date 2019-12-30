class Product < ApplicationRecord
    validates :name, :category, :price, :description, :user_id, presence: true
    validates :category, inclusion: { in: %w(Automotive Books Electronics Handmade Home Outdoors Tools Games Clothing),
    message: "%{value} is not a valid category for a product!" }
    validate :check_name_length
    
    belongs_to :user

    def check_name_length
        unless name.length >= 2
            errors[:name] << "is too short, must be longer than two or more characters"
        end
    end
end
