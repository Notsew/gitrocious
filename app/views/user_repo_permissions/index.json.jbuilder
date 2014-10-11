json.array!(@user_repo_permissions) do |user_repo_permission|
  json.extract! user_repo_permission, :id, :branch, :user_id, :repo_id
  json.url user_repo_permission_url(user_repo_permission, format: :json)
end
