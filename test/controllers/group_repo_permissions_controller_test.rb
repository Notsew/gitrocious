require 'test_helper'

class GroupRepoPermissionsControllerTest < ActionController::TestCase
  setup do
    @group_repo_permission = group_repo_permissions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_repo_permissions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_repo_permission" do
    assert_difference('GroupRepoPermission.count') do
      post :create, group_repo_permission: { branch: @group_repo_permission.branch, group_id: @group_repo_permission.group_id, repo_id: @group_repo_permission.repo_id }
    end

    assert_redirected_to group_repo_permission_path(assigns(:group_repo_permission))
  end

  test "should show group_repo_permission" do
    get :show, id: @group_repo_permission
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_repo_permission
    assert_response :success
  end

  test "should update group_repo_permission" do
    patch :update, id: @group_repo_permission, group_repo_permission: { branch: @group_repo_permission.branch, group_id: @group_repo_permission.group_id, repo_id: @group_repo_permission.repo_id }
    assert_redirected_to group_repo_permission_path(assigns(:group_repo_permission))
  end

  test "should destroy group_repo_permission" do
    assert_difference('GroupRepoPermission.count', -1) do
      delete :destroy, id: @group_repo_permission
    end

    assert_redirected_to group_repo_permissions_path
  end
end
