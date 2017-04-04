json.array! @edge_points do |edge_point|
  json.partial! 'edge_point', edge_point: edge_point
end
