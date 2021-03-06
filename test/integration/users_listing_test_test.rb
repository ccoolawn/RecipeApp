require 'test_helper'

class UsersListingTestTest < ActionDispatch::IntegrationTest

	def setup
		@user = User.create!(firstname: "Billy", lastname: "Robinson", email: "brobinson@example.com",
											password: "password", password_confirmation: "password")
		@user2 = User.create!(firstname: "John", lastname: "Robinson", email: "jrobinson@example.com",
											password: "password1", password_confirmation: "password1")
		@admin_user = User.create!(firstname: "John1", lastname: "Robinson", email: "jrobinson1@example.com",
											password: "password", password_confirmation: "password", admin: true)
	end

	test "should get users listing" do
		get users_path
		assert_template 'users/index'
		assert_select "a[href=?]", user_path(@user), text: "#{@user.firstname} #{@user.lastname}"
		assert_select "a[href=?]", user_path(@user2), text: "#{@user2.firstname} #{@user2.lastname}"
	end

	test "should delete user" do
		sign_in_as(@admin_user, "password")
		get users_path
		assert_template 'users/index'
		assert_difference 'User.count', -1 do
			delete user_path(@user)
		end
		assert_redirected_to users_path
		assert_not flash.empty?
	end
end
