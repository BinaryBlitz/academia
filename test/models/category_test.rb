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

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
 setup do
    @category = categories(:category)
  end

  test 'valid' do
    assert @category.valid?
  end
end
