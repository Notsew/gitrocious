json.array!(@keys) do |key|
  json.extract! key, :id, :value
  json.url key_url(key, format: :json)
end
