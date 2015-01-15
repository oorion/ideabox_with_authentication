require 'test_helper'

class IdeaCategoriesTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  attr_reader :admin, :user

  def setup
    @admin = User.create(
      username: 'admin',
      password: 'password',
      password_confirmation: 'password',
      role: 'admin'
    )

    @user = User.create(
    username: 'user',
    password: 'password',
    password_confirmation: 'password',
    role: 'default'
    )

    visit login_path
  end

  test 'admin can create a category' do
    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    visit new_category_path
    fill_in 'category[name]', with: 'Sports'
    # save_and_open_page

    click_link_or_button 'Create Category'
    assert_equal current_path, categories_path
    within '#categories' do
      assert page.has_content?('Sports')
    end
  end

  test 'user cannot create a category' do
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit new_category_path
    assert_equal current_path, categories_path
    within("#flash_alert") do
      assert page.has_content?('You are not authorized')
    end
  end
end
