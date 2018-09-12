require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor.rb'

class VendorTest < Minitest::Test

  def setup
    @vendor = vendor = Vendor.new("Rocky Mountain Fresh")
  end

  def test_it_exists
    assert_instance_of Vendor, @vendor
  end

  def test_it_takes_arguments
    assert_equal "Rocky Mountain Fresh", @vendor.name
  end

  def test_it_starts_with_no_inventory
    assert_equal ({}), @vendor.inventory
    assert_instance_of Hash, @vendor.inventory
  end

  def test_it_returns_stock_of_given_product
    assert_equal 0, @vendor.check_stock("Peaches")
  end

  def test_it_increases_stock_of_given_product
    @vendor.stock("Peaches", 30)
    assert_equal 30, @vendor.check_stock("Peaches")

    @vendor.stock("Peaches", 25)
    assert_equal 55, @vendor.check_stock("Peaches")

    @vendor.stock("Tomatoes", 12)
    expected = {"Peaches"=>55, "Tomatoes"=>12}
    assert_equal expected, @vendor.inventory
  end

  def test_it_decreases_stock_of_given_product
    @vendor.stock("Peaches", 30)
    @vendor.stock("Tomatoes", 12)
    @vendor.sell("Peaches", 25)
    assert_equal 5, @vendor.check_stock("Peaches")

    expected = {"Peaches"=>5, "Tomatoes"=>12}
    assert_equal expected, @vendor.inventory
  end

  def test_it_does_not_sell_if_quantity_sold_exceeds_stock
    @vendor.stock("Peaches", 30)
    @vendor.sell("Peaches", 35)
    assert_equal 30, @vendor.check_stock("Peaches")
  end


end