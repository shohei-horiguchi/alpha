require 'spec_helper'

describe "Facebook" do

  if User.omniauthable? && Devise.omniauth_providers.include?(:facebook)

    it "is allowed as a method for user registration", :omniauth do
      visit new_user_session_path
      click_link "Sign in with Facebook"
      page.has_content? "Successfully authorized from facebook account."
      page.has_content? "Signed in as josevalim"
      User.where(:email => "user456@example.com").first.should_not be_nil
    end


#    it "enables changing password after following email link" do
#      @user.send("generate_reset_password_token!")
#      visit edit_user_password_path(@user, :reset_password_token => @user.reset_password_token)
#      fill_in "New password", :with => "password"
#      fill_in "Confirm your new password", :with => "password"
#      click_button "Change my password"
#      current_path.should == user_root_path
#      page.has_content? "Your password was changed successfully. You are now signed in."
#    end

#  Scenario: Facebook First Login (required user information is included)
#    When I login with facebook
#    Then I should see "Successfully authorized from facebook account."
#    And I should see "Signed in as josevalim"
#    And "user456@example.com" should have been created by omniauth

#  Scenario: Facebook First Login (user already has an account)
#    When I have a user with email "user456@example.com"
#    And I login with facebook
#    Then I should see "Successfully authorized from facebook account."
#    And I should see "Signed in as person"
#    And "user456@example.com" should not have been created by omniauth

#  Scenario: Unsuccessful Facebook Login (invalid credentials)
#    When I fail to login with facebook due to invalid credentials
#    Then I should see "Could not authorize you from Facebook"
#    And I should be on the login page
#    And I should not be logged in

#  Scenario: Unsuccessful Facebook Login (access denied)
#    When I fail to login with facebook due to access denied
#    Then I should see "Could not authorize you from Facebook"
#    And I should be on the login page
#    And I should not be logged in

#  Scenario: Facebook Logout
#    When I am logged in with facebook
#    And I follow "Sign Out"
#    Then I should be on the home page
#    And I should not be logged in

  end

end
