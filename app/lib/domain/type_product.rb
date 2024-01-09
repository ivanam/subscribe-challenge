class TypeProduct
  CATEGORIES_EXEMPT = %w[book food medical]

  SUB_CATEGORIES = [
    { category_name: "book", values: ["book"] },
    { category_name: "food", values: ["chocolate bar", "box of chocolates", "boxes of chocolates"] },
    { category_name: "medical", values: ["packet of headache pills"] },
    { category_name: "other", values: ["bottle of perfume", "music CD"] }
  ]

  def self.is_exempt(product_name)
    category_name = self.get(product_name)
    CATEGORIES_EXEMPT.include? category_name
  end

  def self.get(product_name)
    product_founded = find_value(product_name)
    product_founded[:category_name]
  end

  def self.is_valid(product_name)
    find_value(product_name).nil? ? false : true
  end

  def self.find_value(product_name)
    product_founded = SUB_CATEGORIES.find { |product| product[:values].include?(product_name) }
    product_founded
  end
end