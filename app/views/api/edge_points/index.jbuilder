json.array! @edge_points do |edge_point|
  json.partial! 'api/edge_points/edge_point', edge_point: edge_point
end
