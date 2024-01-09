require 'minitest/autorun'
require_relative '../../../app/lib/domain/product'
require_relative '../../../app/lib/domain/receipt'

class ReceiptTest < Minitest::Test

  def test_sum_total_taxes
    products = []
    product = Product.new("bottle of perfume", 1.00, false, 1)
    products << product
    products << product
    receipt = Receipt.new(products)
    assert_equal products.size, 2
    assert_equal product.price * 0.1 * products.size, receipt.total_taxes
  end

  def test_sum_total_amount
    products = []
    product = Product.new("bottle of perfume", 1.00, false, 1)
    products << product
    products << product
    receipt = Receipt.new(products)
    assert_equal 2, products.size
    assert_equal (product.price * 0.1 + product.price ) * products.size, receipt.total_amount
  end

  def test_sum_total_taxes_when_is_imported
    products = []
    product = Product.new("bottle of perfume", 1.00, true, 1)
    products << product
    products << product
    receipt = Receipt.new(products)
    assert_equal 2, products.size
    assert_equal (product.price * 0.1 + product.price * 0.05) * products.size, receipt.total_taxes
  end

  def test_sum_total_amount_when_is_imported
    products = []
    product = Product.new("bottle of perfume", 1.00, true, 1)
    products << product
    products << product
    receipt = Receipt.new(products)
    value = (product.price * 0.1 + product.price + product.price * 0.05) * products.size
    assert_equal 2, products.size
    assert_equal value.round(2), receipt.total_amount
  end
end