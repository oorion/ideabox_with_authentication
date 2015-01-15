require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "default user has attributes" do
    user = User.create(username: 'user', password: 'password', role: 'default')
    assert_equal 'user', user.username
    assert_equal 'password', user.password
    assert_equal 'default', user.role
  end

  test "admin user has attributes" do
    user = User.create(username: 'admin', password: 'password', role: 'admin')
    assert_equal 'admin', user.username
    assert_equal 'password', user.password
    assert_equal 'admin', user.role
  end
end
