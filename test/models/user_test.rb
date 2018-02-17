require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user = User.new(firstname: "Cornell", lastname: "Coulon", email: "cornell1001@mac.com",
											password: "password", password_confirmation: "password")
	end

	test "should be valid" do
		assert @user.valid?
	end

	test "firstname should be present" do
		@user.firstname = " "
		assert_not @user.valid?
	end

	test "firstname should be less than 15 characters" do
		@user.firstname = "a" * 16
		assert_not @user.valid?
	end

	test "lastname should be present" do
		@user.lastname = " "
		assert_not @user.valid?
	end

	test "lastname should be less than 15 characters" do
		@user.lastname = "a" * 16
		assert_not @user.valid?
	end

	test "email should be present" do
		@user.email = " "
		assert_not @user.valid?
	end

	test "email should not be too long" do
		@user.email = "a" * 245 + "@example.com"
		assert_not @user.valid?
	end

	test "email should accept valid format" do
		valid_email = %w[user@example.com USER@gmail.com C.firstname@yahoo.ca amy+williams@co.uk.org]
		valid_email.each do |valids|
			@user.email = valids
			assert @user.valid?, "#{valids.inspect} should be valid"
		end
	end

	test "should reject invalid email addresses" do
		invalid_emails = %w[brady@example billy@word,com student.name@gmail kelly@rip+stick.com]
		invalid_emails.each do |invalids|
			@user.email = invalids
			assert_not @user.valid?, "#{invalids.inspect} should be invalid"
		end
	end

	test "email should be unique" do
		duplicate_user = @user.dup
		duplicate_user.email = @user.email.upcase
		@user.save
		assert_not duplicate_user.valid?
	end

	test "email should be lowercase before hitting db" do
		mixed_email = "BillY@Gmail.com"
		@user.email = mixed_email
		@user.save
		assert_equal mixed_email.downcase, @user.reload.email
	end

	test "password should be present" do
		@user.password = @user.password_confirmation = " "
		assert_not @user.valid?
	end

	test "password should be at least 8 charecters" do
		@user.password = @user.password_confirmation = "x" * 7
		assert_not @user.valid?
	end

	test "assciated should be destroyed" do
		@user.save
		@user.recipes.create!(ingredient: "test delete", recipeName: "test delete", description: "test deletetest deletetest deletetest deletetest deletetest deletetest delete", instructions: "test deletetest delete test delete test delete test delete test delete")
		assert_difference 'Recipe.count', -1 do
			@user.destroy
		end
	end
end