class Recipe < ApplicationRecord
	belongs_to :user
	validates :user_id, presence: true
	validates :ingredient, presence: true
	validates :recipeName, presence: true
	validates :instructions, presence: true, length: {minimum: 25, maximum: 5000}
	validates :description, presence: true, length: {minimum: 5, maximum: 500}
end