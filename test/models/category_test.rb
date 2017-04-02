require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
 setup do
    @category = categories(:category)
  end

  test 'valid' do
    assert @category.valid?
  end
end
