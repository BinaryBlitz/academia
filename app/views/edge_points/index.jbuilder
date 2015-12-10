json.array! @edge_points do |edge_point|
  json.extract! edge_point, :latitude, :longitude
end
