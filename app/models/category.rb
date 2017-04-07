# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  stuff      :boolean          default(FALSE)
#

class Category < ApplicationRecord
  has_many :dishes, dependent: :destroy

  validates :name, presence: true
  validate :stuff_uniqueness

  scope :stuff, -> { where(stuff: true) }

  private

  def stuff_uniqueness
    return unless stuff?
    if Category.where.not(id: id).stuff.any?
      errors.add(:base, 'Нельзя добавить больше 1 категории с дополнительными блюдами')
    end
  end
end
