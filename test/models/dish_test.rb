# == Schema Information
#
# Table name: dishes
#
#  id            :integer          not null, primary key
#  name          :string
#  description   :text
#  price         :integer
#  image         :string
#  stuff         :boolean          default(FALSE)
#  lunch         :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  subtitle      :string
#  hidden        :boolean          default(FALSE)
#  proteins      :float
#  fats          :float
#  carbohydrates :float
#  calories      :float
#

require 'test_helper'

class DishTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
