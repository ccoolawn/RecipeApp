class User < ApplicationRecord
	include Gravtastic
  gravtastic :secure => true, :size => 30, :rating => 'PG', :default => "retro"
	has_many :recipes
	before_save  {self.email = email.downcase}
	validates :firstname, presence: true, length: {maximum: 15}
	validates :lastname, presence: true, length: {maximum: 15}
	VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255}, format: { with: VALID_EMAIL_REGEX, message: "only allows valid emails" }, uniqueness: {case_sensitive: false}
	has_secure_password
	validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
end