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
#  device_token      :string
#  platform          :string
#

require 'test_helper'

class CourierTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
