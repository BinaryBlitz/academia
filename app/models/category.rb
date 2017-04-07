# == Schema Information
#
# Table name: categories
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  complementary :boolean          default(FALSE)
#

class Category < ApplicationRecord
  has_many :dishes, dependent: :destroy

  validates :name, presence: true
  validate :complementary_uniqueness

  scope :complementary, -> { where(complementary: true) }

  private

  def complementary_uniqueness
    return unless complementary?
    if Category.where.not(id: id).complementary.any?
      errors.add(:base, 'Нельзя добавить больше 1 категории с дополнительными блюдами')
    end
  end
end
