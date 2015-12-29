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

  has_many :couriers

  acts_as_mappable default_units: :kms, lat_column_name: :latitude, lng_column_name: :longitude

  def to_s
    "#{latitude}, #{longitude}"
  end
end
