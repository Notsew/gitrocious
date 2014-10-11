json.array!(@group_repo_permissions) do |group_repo_permission|
  json.extract! group_repo_permission, :id, :branch, :group_id, :repo_id
  json.url group_repo_permission_url(group_repo_permission, format: :json)
end
