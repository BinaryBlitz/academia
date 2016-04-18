json.array! @payment_cards do |payment_card|
  json.extract! :id, :number, :created_at, :updated_at
end
