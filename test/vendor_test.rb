require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor.rb'

class VendorTest < Minitest::Test

  def test_it_exists
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_instance_of Vendor, vendor
  end

  def test_it_takes_arguments
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_equal "Rocky Mountain Fresh", vendor.name
  end

  def test_it_starts_with_no_inventory
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_equal ({}), vendor.inventory
    assert_instance_of Hash, vendor.inventory
  end

  def test_it_returns_stock_of_given_product
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_equal 0, vendor.check_stock("Peaches")
  end

  def test_it_increases_stock_of_given_product
    vendor = Vendor.new("Rocky Mountain Fresh")
    vendor.stock("Peaches", 30)
    assert_equal 30, vendor.check_stock("Peaches")

    vendor.stock("Peaches", 25)
    assert_equal 55, vendor.check_stock("Peaches")

    vendor.stock("Tomatoes", 12)
    expected = {"Peaches"=>55, "Tomatoes"=>12}
    assert_equal expected, vendor.inventory
  end

end