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

  test 'test user is shown their ideas upon login' do
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    idea = Idea.create(title: 'some idea', description: 'blah', user_id: user.id)
    visit user_path(user)
    within '#ideas' do
      assert page.has_content?(idea.title)
    end
  end
end
