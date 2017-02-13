# == Schema Information
#
# Table name: dishes
#
#  id            :integer          not null, primary key
#  name          :string
#  description   :text
#  price         :integer
#  image         :string
#  stuff         :boolean          default("false")
#  lunch         :boolean          default("false")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  subtitle      :string
#  hidden        :boolean          default("false")
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
