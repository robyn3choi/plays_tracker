require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin     = users(:robyn)
    @non_admin = users(:sarah)
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_redirected_to root_path
  end

  test "index as admin" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
  end
end
