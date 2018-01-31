class Recipe < ApplicationRecord
	validates :ingredient, presence: true
	validates :description, presence: true, length: {minimum: 5, maximum: 500}
end