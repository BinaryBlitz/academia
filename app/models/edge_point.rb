# == Schema Information
#
# Table name: edge_points
#
#  id         :integer          not null, primary key
#  latitude   :float
#  longitude  :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EdgePoint < ActiveRecord::Base
  include Geocodable

  def self.to_polygon
    points = all.map { |point| Geokit::LatLng.new(point.latitude, point.longitude) }
    Geokit::Polygon.new(points)
  end
end
