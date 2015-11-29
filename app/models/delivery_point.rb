# == Schema Information
#
# Table name: delivery_points
#
#  id         :integer          not null, primary key
#  latitude   :float
#  longitude  :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DeliveryPoint < ActiveRecord::Base
  include Geocodable
end
