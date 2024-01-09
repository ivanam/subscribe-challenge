require 'readline'
require_relative '../domain/product'
require_relative '../domain/receipt'
require_relative '../domain/type_product'

class PurchaseService
  attr_accessor :purchased_items

  def initialize
    @purchased_items = []
  end

  def create_products(file_name)
    regex = /^(\d+)\s*(imported)?\s*([\w\s]+)\sat\s(\d+\.\d{2})$/

    begin
      File.open(file_name, 'r') do |file|
        file.each_line do |input|
          matches = input.match(regex)

          if matches && TypeProduct.is_valid(matches[3])
            create_product(matches)
          else
            puts "File does not have the expected format"
            break
          end
        end
      end
      rescue Errno::ENOENT
        puts "File #{file_name} was not found."
      rescue StandardError => e
        puts "An error occurred when opening the file: #{e.message}"
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

  def enter_file_name
    puts "Enter the name of the file that contains the products"
    puts "The format of each product entered should be: <quantity> <name> at <price with two decimals>"

    Readline.readline("-> ")
  end

  def generate_receipt
    file_name = enter_file_name
    create_products(file_name)
    print_receipt
  end
end