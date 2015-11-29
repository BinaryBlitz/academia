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
end
