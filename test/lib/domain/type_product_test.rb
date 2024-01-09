require 'minitest/autorun'
require_relative '../../../app/lib/domain/type_product'

class TypeProductTest < Minitest::Test

  def test_is_valid_with_invalid_name
    name = "name_invalid"
    assert_equal false, TypeProduct.is_valid(name)

  end

  def test_is_valid_with_valid_name
    name = "chocolate bar"
    assert_equal true, TypeProduct.is_valid(name)
  end

  def test_get_type_with_invalid_name
    name = "name_invalid"
    assert_equal false, TypeProduct.is_valid(name)
  end

  def test_is_exempt_when_is_food
    name = "chocolate bar"
    assert_equal true, TypeProduct.is_exempt(name)
  end

  def test_is_exempt_when_is_other_type
    name = "music CD"
    assert_equal false, TypeProduct.is_exempt(name)
  end
end