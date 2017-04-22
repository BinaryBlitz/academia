json.cache! payment_card do
  json.extract! payment_card, :id, :binding_id, :number, :created_at, :updated_at
end
