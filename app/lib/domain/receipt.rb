class Receipt
  def initialize(products)
    @products = products
  end

  def total_taxes
    @products.sum { |product| product.total_taxes }
  end

  def total_amount
    @products.sum { |product| product.total_amount }
  end
end