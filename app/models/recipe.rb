class Recipe < ApplicationRecord
	belongs_to :user
	validates :user_id, presence: true
	validates :ingredient, presence: true
	validates :description, presence: true, length: {minimum: 5, maximum: 500}
end