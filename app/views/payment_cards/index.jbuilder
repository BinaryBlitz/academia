json.array! @payment_cards do |payment_card|
  json.partial! 'payment_card', payment_card: payment_card
end
