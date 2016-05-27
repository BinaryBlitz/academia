# == Schema Information
#
# Table name: payment_cards
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  number     :string           not null
#  binding_id :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PaymentCard < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :number, presence: true
  validates :binding_id, presence: true, uniqueness: { scope: :user }
end
