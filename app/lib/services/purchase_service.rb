require 'readline'
require_relative '../domain/product'
require_relative '../domain/receipt'
require_relative '../domain/type_product'

class PurchaseService
  attr_accessor :purchased_items

  def initialize
    @purchased_items = []
  end

  def enter_products
    puts "Enter the products you wish to buy"
    puts "the format to enter the data is: <quantity> <name> at <price with two decimals>"
    puts "when you do not want to enter more products, you can enter the character 'n'"
    loop do
      input = Readline.readline("-> ")
      regex = /^(\d+)\s*(imported)?\s*([\w\s]+)\sat\s(\d+\.\d{2})$/
      break if input == "n"

      matches = input.match(regex)

      if matches && TypeProduct.is_valid(matches[3])
        create_product(matches)
      else
        puts "The chain does not match the expected format"
      end
    end
  end

  def add_item(product)
    @purchased_items << product
  end

  def print_receipt
    receipt = Receipt.new(@purchased_items)

    @purchased_items.each do |product|
      imported = product.imported == true ? "imported" : nil
      if !imported.nil?
        puts "#{product.quantity} #{imported} #{product.name}: #{product.total_amount.round_off}"
      else
        puts "#{product.quantity} #{product.name}: #{product.total_amount.round_off}"
      end
    end

    puts "\nSales Taxes: #{receipt.total_taxes.round_off}"
    puts "Total: #{receipt.total_amount.round_off}"
  end

  def create_product(matches)
    quantity = matches[1].to_i
    imported = !matches[2].nil?
    name = matches[3]
    price = matches[4].to_f
    product = Product.new(name, price, imported, quantity)
    add_item(product)
  end

  def generate_receipt
    enter_products
    print_receipt
  end
end