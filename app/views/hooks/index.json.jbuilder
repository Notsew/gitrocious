json.array!(@hooks) do |hook|
  json.extract! hook, :id, :type, :text, :repo_id
  json.url hook_url(hook, format: :json)
end
