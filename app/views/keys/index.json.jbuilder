json.array!(@keys) do |key|
  json.extract! key, :id, :value, :user_id
  json.url key_url(key, format: :json)
end
