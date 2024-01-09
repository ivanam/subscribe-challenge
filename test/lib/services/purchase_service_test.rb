require 'minitest/autorun'
require 'stringio'
require_relative '../../../app/lib/services/purchase_service'

class PurchaseServiceTest < Minitest::Test
  def test_generate_receipt_with_first_input
    expected_output = <<~EXPECTED
      2 book: 24.98
      1 music CD: 16.49
      1 chocolate bar: 0.85

      Sales Taxes: 1.50
      Total: 42.32
    EXPECTED

    purchase_service = PurchaseService.new
    regex = /^(\d+)\s*(imported)?\s*([\w\s]+)\sat\s(\d+\.\d{2})$/

    input = "2 book at 12.49"
    matches = input.match(regex)
    purchase_service.create_product(matches)

    input = "1 music CD at 14.99"
    matches = input.match(regex)
    purchase_service.create_product(matches)

    input = "1 chocolate bar at 0.85"
    matches = input.match(regex)
    purchase_service.create_product(matches)

    output_source = StringIO.new
    $stdout = output_source

    purchase_service.print_receipt

    $stdout = STDOUT

    assert_equal 3, purchase_service.purchased_items.size
    assert_equal expected_output, output_source.string
  end

  def test_generate_receipt_with_second_input
    expected_output = <<~EXPECTED
      1 imported box of chocolates: 10.50
      1 imported bottle of perfume: 54.65
  
      Sales Taxes: 7.65
      Total: 65.15
    EXPECTED

    purchase_service = PurchaseService.new
    regex = /^(\d+)\s*(imported)?\s*([\w\s]+)\sat\s(\d+\.\d{2})$/

    input = "1 imported box of chocolates at 10.00"
    matches = input.match(regex)
    purchase_service.create_product(matches)

    input = "1 imported bottle of perfume at 47.50"
    matches = input.match(regex)
    purchase_service.create_product(matches)

    output_source = StringIO.new
    $stdout = output_source

    purchase_service.print_receipt

    $stdout = STDOUT

    assert_equal 2, purchase_service.purchased_items.size
    assert_equal expected_output, output_source.string
  end

  def test_generate_receipt_with_third_input
    expected_output = <<~EXPECTED
      1 imported bottle of perfume: 32.19
      1 bottle of perfume: 20.89
      1 packet of headache pills: 9.75
      3 imported boxes of chocolates: 35.55

      Sales Taxes: 7.90
      Total: 98.38
    EXPECTED

    purchase_service = PurchaseService.new
    regex = /^(\d+)\s*(imported)?\s*([\w\s]+)\sat\s(\d+\.\d{2})$/

    input = "1 imported bottle of perfume at 27.99"
    matches = input.match(regex)
    purchase_service.create_product(matches)

    input = "1 bottle of perfume at 18.99"
    matches = input.match(regex)
    purchase_service.create_product(matches)

    input = "1 packet of headache pills at 9.75"
    matches = input.match(regex)
    purchase_service.create_product(matches)

    input = "3 imported boxes of chocolates at 11.25"
    matches = input.match(regex)
    purchase_service.create_product(matches)

    output_source = StringIO.new
    $stdout = output_source

    purchase_service.print_receipt

    $stdout = STDOUT

    assert_equal 4, purchase_service.purchased_items.size
    assert_equal expected_output, output_source.string
  end
end
