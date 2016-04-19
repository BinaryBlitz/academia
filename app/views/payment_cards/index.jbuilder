json.array! @payment_cards do |payment_card|
  json.extract! payment_card, :id, :binding_id, :number, :created_at, :updated_at
end
