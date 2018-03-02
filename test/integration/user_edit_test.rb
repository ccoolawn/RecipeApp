require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest

	def setup
		@user = User.create!(firstname: "Ryan", lastname: "Johnson", email: "rjohnson@example.com",
											password: "password", password_confirmation: "password")
		@user2 = User.create!(firstname: "Cyan", lastname: "Johnson", email: "cjohnson@example.com",
											password: "password", password_confirmation: "password")
		@admin_user = User.create!(firstname: "Ryan2", lastname: "Johnson2", email: "rjohnson2@example.com",
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

	test "accept a valid edit" do
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

	test "accept edit attempt by admin user" do
		sign_in_as(@admin_user, "password")
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), params: {user: {firstname: "Ryan3", lastname: "Johnson3", email: "rjohnson3@example.com"}}
		assert_redirected_to @user
		assert_not flash.empty?
		@user.reload
		assert_match "Ryan3", @user.firstname
		assert_match "Johnson3", @user.lastname
		assert_match "rjohnson3@example.com", @user.email
	end

	test "redirect edit attempt by another non-admin user" do
		sign_in_as(@user2, "password")
		updated_firstname = "Billy"
		updated_lastname = "Williams"
		updated_email = "bwilliams@example.com"
		patch user_path(@user), params: {user: {firstname: updated_firstname, lastname: updated_lastname, email: updated_email}}
		assert_redirected_to users_path
		assert_not flash.empty?
		@user.reload
		assert_match "Ryan", @user.firstname
		assert_match "Johnson", @user.lastname
		assert_match "rjohnson@example.com", @user.email
	end
end
