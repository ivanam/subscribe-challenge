require_relative '../domain/type_product'
require_relative '../utils/numeric'

class Product
  attr_accessor :name, :price, :imported, :quantity

  def initialize(name, price, imported = false, quantity)
    @name = name
    @price = price
    @imported = imported
    @quantity = quantity
  end

  def basic_tax
    (quantity * (TypeProduct.is_exempt(name) ? 0 : (price * 0.1).ceil_to_nearest(0.05))).round(2)
  end

  def import_tax
    (quantity * (imported ? (price * 0.05).ceil_to_nearest(0.05) : 0)).round(2)
  end

  def total_taxes
    basic_tax + import_tax
  end

  def total_amount
    quantity * price + total_taxes
  end
end