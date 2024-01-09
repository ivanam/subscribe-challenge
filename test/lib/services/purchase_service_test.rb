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
    purchase_service.create_products("input_1.txt")

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
    purchase_service.create_products("input_2.txt")

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
    purchase_service.create_products("input_3.txt")

    output_source = StringIO.new
    $stdout = output_source

    purchase_service.print_receipt

    $stdout = STDOUT
    assert_equal 4, purchase_service.purchased_items.size
    assert_equal expected_output, output_source.string
  end
end
