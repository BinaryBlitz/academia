json.array!(@users) do |user|
  json.extract! user, :id, :first_name, :last_name, :email, :phone_number, :password_digest, :vk_id, :fb_id
  json.url user_url(user, format: :json)
end
