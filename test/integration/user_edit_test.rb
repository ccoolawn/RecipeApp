require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest

	def setup
		@user = User.create!(firstname: "Ryan", lastname: "Johnson", email: "rjohnson@example.com",
											password: "password", password_confirmation: "password")
	end

	test "reject an invalid edit" do
		sign_in_as(@user, "password")
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), params: {user: {firstname: " ", lastname: " ", email: "rjohnson@example.com"}}
		assert_template 'users/edit'
		assert_select 'h2.card-title'
		assert_select 'div.card-body'
	end

	test "accept a valid signup" do
		sign_in_as(@user, "password")
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), params: {user: {firstname: "Ryan1", lastname: "Johnson1", email: "rjohnson1@example.com"}}
		assert_redirected_to @user
		assert_not flash.empty?
		@user.reload
		assert_match "Ryan1", @user.firstname
		assert_match "Johnson1", @user.lastname
		assert_match "rjohnson1@example.com", @user.email
	end
end
