# == Schema Information
#
# Table name: orders
#
#  id               :integer          not null, primary key
#  address          :text
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  status           :string
#  scheduled_for    :datetime
#  latitude         :float
#  longitude        :float
#  rating           :integer
#  review           :text
#  courier_id       :integer
#  revenue          :integer
#  discount         :integer
#  balance_discount :integer
#

class Order < ActiveRecord::Base
  FREE_DELIVERY_FROM = 1000
  DELIVERY_COST = 200
  MAX_DELIVERY_MINUTES = 40

  before_save :ensure_presence_of_line_items
  before_save :set_status

  belongs_to :user
  belongs_to :courier

  has_one :payment
  has_many :line_items, dependent: :destroy, inverse_of: :order
  accepts_nested_attributes_for :line_items

  validates :user, presence: true
  validates :address, presence: true
  validates :rating, inclusion: { in: 1..5 }, allow_blank: true
  validate :inside_delivery_zone?

  include Geocodable

  extend Enumerize
  enumerize :status, in: [:unpaid, :new, :on_the_way, :delivered, :rejected], default: :unpaid

  scope :visible, -> { where(status: [:on_the_way, :delivered]) }
  scope :delivered, -> { where(status: :delivered) }
  scope :rejected, -> { where(status: :rejected) }
  scope :on_the_way, -> { where(status: :on_the_way) }
  scope :unassigned, -> { on_the_way.where(courier: nil) }
  scope :late, -> { on_the_way.where('created_at < ?', MAX_DELIVERY_MINUTES.minutes.ago) }

  def total_price
    sum = line_items_price
    # Discount
    self.discount = sum * (user.discount / 100.0)
    sum -= discount
    # Balance
    self.balance_discount = user.balance > sum ? sum : user.balance
    sum -= balance_discount
    # Delivery
    sum += DELIVERY_COST if sum < FREE_DELIVERY_FROM
    self.revenue = sum - discount - balance_discount
    save
    sum.to_i
  end

  def redeem_balance
    if balance_discount > user.balance
      user.update(balance: 0)
    else
      user.update(balance: user.balance - balance_discount)
    end
  end

  private

  def line_items_price
    @line_items_price ||= line_items.inject(0) { |a, e| a += e.total_price }
  end

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

  def set_status
    if status == 'new' && courier.present?
      self.status = :on_the_way
      notify_status_change
    end
  end

  def notify_status_change
    Notifier.new(user, 'Заказ в пути.')
    SmsSender.new(user.phone_number, 'Заказ в пути.')
  end
end
