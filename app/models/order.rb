# == Schema Information
#
# Table name: orders
#
#  id            :integer          not null, primary key
#  address       :text
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  status        :string
#  scheduled_for :datetime
#  latitude      :float
#  longitude     :float
#  rating        :integer
#  review        :text
#

class Order < ActiveRecord::Base
  before_save :ensure_presence_of_line_items

  belongs_to :user

  has_one :payment
  has_many :line_items, dependent: :destroy, inverse_of: :order
  accepts_nested_attributes_for :line_items

  validates :user, presence: true
  validates :address, presence: true
  validates :rating, inclusion: { in: 1..5 }, allow_blank: true
  validate :inside_delivery_zone?

  include Geocodable

  extend Enumerize
  enumerize :status, in: [:new, :on_the_way, :delivered, :rejected], default: :new

  scope :visible, -> { where(status: [:on_the_way, :delivered]) }

  def total_price
    sum = 0
    line_items.each { |item| sum += item.total_price }
    sum *= (1.0 - (user.discount / 100.0))
    sum = user.balance > sum ? 0 : sum - user.balance
    sum.to_i
  end

  def redeem_balance
    if user.balance > total_price
      user.update(balance: user.balance - total_price)
    else
      user.update(balance: 0)
    end
  end

  private

  def ensure_presence_of_line_items
    if line_items.empty?
      errors.add(:line_items, "can't be blank")
      false
    else
      true
    end
  end

  def inside_delivery_zone?
    return unless latitude && longitude
    errors.add(:base, 'outside delivery zone') unless EdgePoint.to_polygon.contains?(to_point)
  end

  def to_point
    Geokit::LatLng.new(latitude, longitude)
  end
end
