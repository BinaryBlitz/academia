module Authenticable
  extend ActiveSupport::Concern

  module ClassMethods
    def find_or_create_from_vk(vk)
      vk_user = vk.users.get(fields: [:screen_name, :email]).first
      user = find_by(vk_id: vk_user.uid)

      user || create!(
        first_name: vk_user.first_name, last_name: vk_user.last_name,
        password: SecureRandom.hex, email: vk_user.email, vk_id: vk_user.uid,
      )
    end

    def find_or_create_from_fb(graph)
      fb_user = graph.get_object('me?fields=id,first_name,last_name,name,email')
      user = find_by(facebook_id: fb_user['id'])

      user || create!(
        first_name: fb_user['first_name'], last_name: fb_user['last_name'],
        password: SecureRandom.hex, email: fb_user['email'], fb_id: fb_user['id']
      )
    end
  end
end
