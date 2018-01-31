class User < ApplicationRecord
	before_save  {self.email = email.downcase}
	validates :firstname, presence: true, length: {maximum: 15}
	validates :lastname, presence: true, length: {maximum: 15}
	VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255}, format: { with: VALID_EMAIL_REGEX, message: "only allows valid emails" }, uniqueness: {case_sensitive: false}
end