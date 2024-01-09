require 'minitest/autorun'
require_relative '../../../app/lib/domain/product'


class ProductTest < Minitest::Test

  def test_basic_tax_zero_if_food_is_involved
    product = Product.new("book", 1.00, false, 1)
    assert_equal 0, product.basic_tax
  end

  def test_basic_tax_is_ten_percent_if_other_type_involved
    product = Product.new("bottle of perfume", 1.00, false, 1)
    assert_equal product.price * 0.1, product.basic_tax
  end

  def test_basic_tax_is_ten_percent_if_other_type_involved_more_than_1_product
    product = Product.new("bottle of perfume", 1.00, false, 2)
    assert_equal product.quantity * product.price * 0.1, product.basic_tax
  end

  def test_imported_tax_zero_if_is_not_imported
    product = Product.new("book", 1.00, false, 1)
    assert_equal 0, product.import_tax
  end

  def test_imported_tax_five_percent_if_is_not_imported_more_than_1_product
    product = Product.new("bottle of perfume", 1.00, true, 2)
    assert_equal product.quantity * product.price * 0.05, product.import_tax
  end

  def test_total_taxes
    product = Product.new("bottle of perfume", 1.00, false, 2)
    assert_equal product.quantity * product.price * 0.1, product.total_taxes
  end

  def test_total_taxes_imported
    product = Product.new("bottle of perfume", 1.00, true, 2)
    tax = product.quantity * (product.price * 0.1 + product.price * 0.05)
    assert_equal tax, product.total_taxes
  end

  def test_total_cost
    product = Product.new("bottle of perfume", 1.00, true, 2)
    tax = product.quantity * (product.price * 0.1 + product.price * 0.05)
    value = tax + product.price * product.quantity
    assert_equal value.round(2), product.total_amount
  end

end
