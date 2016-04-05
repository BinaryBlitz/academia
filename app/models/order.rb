# == Schema Information
#
# Table name: orders
#
#  id                :integer          not null, primary key
#  address           :text
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  status            :string
#  scheduled_for     :datetime
#  latitude          :float
#  longitude         :float
#  rating            :integer
#  review            :text
#  courier_id        :integer
#  revenue           :integer
#  discount          :integer
#  balance_discount  :integer
#  delivered_at      :datetime
#  delivery_point_id :integer
#  deliver_now       :boolean          default(TRUE)
#

class Order < ActiveRecord::Base
  FREE_DELIVERY_FROM = 1000
  DELIVERY_COST = 200
  MAX_DELIVERY_MINUTES = 40
  DELIVERY_TIME = 30

  before_validation :set_delivery_point
  before_validation :set_deliver_now
  before_save :ensure_presence_of_line_items
  before_save :set_status
  before_save :set_delivery_time
  before_save :notify_couriers

  belongs_to :user
  belongs_to :courier
  belongs_to :delivery_point

  has_one :payment
  has_many :line_items, dependent: :destroy, inverse_of: :order
  accepts_nested_attributes_for :line_items

  validates :user, presence: true
  validates :address, presence: true
  validates :delivery_point, presence: true
  validates :rating, inclusion: { in: 1..5 }, allow_blank: true
  validates :scheduled_for, presence: true, unless: 'deliver_now?', on: :create
  validates :scheduled_for, presence: true, if: 'status.new?', on: :update
  validate :valid_delivery_time?, on: :create
  validate :inside_delivery_zone?

  include Geocodable

  extend Enumerize
  enumerize :status, in: [:unpaid, :new, :on_the_way, :delivered, :rejected], default: :unpaid

  scope :visible, -> { where(status: [:on_the_way, :delivered]) }
  scope :delivered, -> { where(status: :delivered) }
  scope :unpaid, -> { where(status: :unpaid) }
  scope :on_the_way, -> { where(status: :on_the_way) }
  scope :unassigned, -> { where(status: :new) }
  scope :with_reviews, -> { where('rating IS NOT NULL OR review IS NOT NULL') }
  scope :late, -> { on_the_way.where('created_at < ?', MAX_DELIVERY_MINUTES.minutes.ago) }

  def total_price
    sum = line_items_price
    # Delivery
    sum += DELIVERY_COST if sum < FREE_DELIVERY_FROM
    # Discount
    self.discount = sum * (user.discount / 100.0)
    sum -= discount
    # Balance
    self.balance_discount = user.balance > sum ? sum : user.balance
    sum -= balance_discount
    # Stats
    self.revenue = sum - discount - balance_discount
    # No zero  payments
    sum = 1 if sum <= 0
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

  def to_coordinate_s
    "#{latitude}, #{longitude}"
  end

  def line_items_price
    @line_items_price ||= line_items.inject(0) { |a, e| a += e.total_price }
  end

  def set_paid
    self.scheduled_for = DELIVERY_TIME.minutes.from_now if deliver_now?
    self.status = 'new'
    save
    send_email
  end

  private

  def send_email
    return unless status == 'new'
    OrderMailer.order_email(self).deliver_now
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
    return unless latitude && longitude && EdgePoint.count > 0

    errors.add(:base, 'outside delivery zone') unless EdgePoint.to_polygon.contains?(to_point)
  end

  def valid_delivery_time?
    return unless scheduled_for

    errors.add(:scheduled_for, 'must be greater than now') if scheduled_for <= Time.zone.now
  end

  def to_point
    Geokit::LatLng.new(latitude, longitude)
  end

  def set_status
    if status == 'new' && courier.present?
      self.status = 'on_the_way'
      notify_status_change
    end
    true
  end

  def set_delivery_time
    if status == 'delivered'
      self.delivered_at = Time.zone.now
    end
    true
  end

  def notify_couriers
    return unless status_changed? && status == 'new'
    delivery_point.notify_couriers
    true
  end

  def set_delivery_point
    self.delivery_point = DeliveryPoint.closest(origin: to_point).try(:first)
  end

  def set_deliver_now
    return unless new_record?

    self.deliver_now = false if scheduled_for.present?
    return
  end

  def notify_status_change
    Notifier.new(user, 'Курьер в пути.')
    SmsSender.new(user.phone_number, 'Курьер в пути.')
  end
end
