require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest

  test "should get signup path" do
  	get signup_path
    assert_response :success
  end

  test "reject an invalid signup" do
  	get signup_path
  	assert_no_difference "User.count" do
  		post users_path, params: {user: {firstname: " ", lastname: " ", email: " ", password: "password",
  																			password_confirmation: " "}}
  	end
  	assert_template 'users/new'
		assert_select 'h2.card-title'
		assert_select 'div.card-body'
  end

  test "accept a valid signup" do
  	get signup_path
  	assert_difference "User.count", 1 do
  		post users_path, params: {user: {firstname: "Cornell ", lastname: "Coulon ", email: "cornell@example.com", password: "password", password_confirmation: "password"}}
  	end
  	follow_redirect!
  	assert_template 'users/show'
		assert_not flash.empty?
  end
end
