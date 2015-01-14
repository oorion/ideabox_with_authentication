require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  attr_reader :user

  def setup
    @user = User.create(username: 'example', password: 'password')
    visit login_path
  end

  test "the user can login" do
    visit login_path
    fill_in "session[username]", with: 'example'
    fill_in "session[password]", with: 'password'
    click_link_or_button 'Login'
    within '#flash_notice' do
      assert page.has_content?('Login successful')
    end

    within '#banner' do
      assert page.has_content?('Welcome example')
    end
  end

  test 'unregistered user cannot log in' do
    visit login_path
    fill_in "session[username]", with: nil
    fill_in "session[password]", with: nil
    click_link_or_button 'Login'

    within '#flash_error' do
      assert page.has_content?('Invalid Login')
    end
    assert_equal current_path, login_path
  end

  test 'test user has ideas' do
    ApplicationController.any_instance.stub(:current_user).returns(user)
    visit user_path(user)
    within '#ideas' do
      assert page.has_content?('some idea')
    end
  end
end
