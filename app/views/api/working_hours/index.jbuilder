json.array! @working_hours do |working_hour|
  json.extract! working_hour, :id
  json.current_time Time.zone.now
  json.start_hour working_hour.starts_at /  60
  json.start_min working_hour.starts_at % 60
  json.end_hour working_hour.ends_at /  60
  json.end_min working_hour.ends_at % 60
end
