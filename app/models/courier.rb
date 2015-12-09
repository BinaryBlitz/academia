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
#

class Courier < ActiveRecord::Base
  belongs_to :delivery_point
end
