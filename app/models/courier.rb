# == Schema Information
#
# Table name: couriers
#
#  id                :integer          not null, primary key
#  name              :string
#  phone_number      :string
#  password_digest   :string
#  delivery_point_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  api_token         :string
#

class Courier < ActiveRecord::Base
  belongs_to :delivery_point

  validates :name, presence: true
  validates :phone_number, presence: true, phony_plausible: true
  validates :delivery_point, presence: true

  phony_normalize :phone_number, default_country_code: 'RU'

  has_secure_password
  validates :password, length: { minimum: 6 }, allow_nil: true
  has_secure_token :api_token
end
