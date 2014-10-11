require 'test_helper'

class UserRepoPermissionsControllerTest < ActionController::TestCase
  setup do
    @user_repo_permission = user_repo_permissions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_repo_permissions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_repo_permission" do
    assert_difference('UserRepoPermission.count') do
      post :create, user_repo_permission: { branch: @user_repo_permission.branch, repo_id: @user_repo_permission.repo_id, user_id: @user_repo_permission.user_id }
    end

    assert_redirected_to user_repo_permission_path(assigns(:user_repo_permission))
  end

  test "should show user_repo_permission" do
    get :show, id: @user_repo_permission
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_repo_permission
    assert_response :success
  end

  test "should update user_repo_permission" do
    patch :update, id: @user_repo_permission, user_repo_permission: { branch: @user_repo_permission.branch, repo_id: @user_repo_permission.repo_id, user_id: @user_repo_permission.user_id }
    assert_redirected_to user_repo_permission_path(assigns(:user_repo_permission))
  end

  test "should destroy user_repo_permission" do
    assert_difference('UserRepoPermission.count', -1) do
      delete :destroy, id: @user_repo_permission
    end

    assert_redirected_to user_repo_permissions_path
  end
end
