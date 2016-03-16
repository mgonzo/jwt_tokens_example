json.array!(@users) do |user|
  json.extract! user, :id, :name, :password, :token, :uuid
  json.url user_url(user, format: :json)
end
