# == Schema Information
#
# Table name: promo_codes
#
#  id         :integer          not null, primary key
#  code       :string
#  discount   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PromoCode < ActiveRecord::Base
  before_save lambda { self.code = code.upcase }

  validates :code, presence: true, uniqueness: { case_sensitive: false }
  validates :discount, numericality: { greater_than: 0 }
end
