require 'minitest/autorun'
require 'minitest/pride'
require './lib/market.rb'
require './lib/vendor.rb'

class MarketTest < Minitest::Test

  def test_it_exists
    market = Market.new("South Pearl Street Farmers Market")
    assert_instance_of Market, market
  end

  def test_it_takes_arguments
    market = Market.new("South Pearl Street Farmers Market")
    assert_equal "South Pearl Street Farmers Market", market.name
  end

  def test_it_starts_with_no_vendors
    market = Market.new("South Pearl Street Farmers Market")
    assert_equal [], market.vendors
    assert_instance_of Array, market.vendors
  end

  def test_it_adds_vendors_to_vendors_array
    market = Market.new("South Pearl Street Farmers Market")
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)    
    vendor_1.stock("Tomatoes", 7)    
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")    
    vendor_2.stock("Banana Nice Cream", 50)    
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)    
    vendor_3 = Vendor.new("Palisade Peach Shack")    
    vendor_3.stock("Peaches", 65)    
    market.add_vendor(vendor_1)    
    market.add_vendor(vendor_2)    
    market.add_vendor(vendor_3)
    expected = [vendor_1, vendor_2, vendor_3]
    assert_equal expected, market.vendors
  end

  def test_it_returns_names_of_all_vendors_in_market
    market = Market.new("South Pearl Street Farmers Market")
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)    
    vendor_1.stock("Tomatoes", 7)    
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")    
    vendor_2.stock("Banana Nice Cream", 50)    
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)    
    vendor_3 = Vendor.new("Palisade Peach Shack")    
    vendor_3.stock("Peaches", 65)    
    market.add_vendor(vendor_1)    
    market.add_vendor(vendor_2)    
    market.add_vendor(vendor_3)
    expected = ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"]
    assert_equal expected, market.vendor_names
  end

  def test_it_returns_all_vendors_that_sell_a_given_product
    market = Market.new("South Pearl Street Farmers Market")
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)    
    vendor_1.stock("Tomatoes", 7)    
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")    
    vendor_2.stock("Banana Nice Cream", 50)    
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)    
    vendor_3 = Vendor.new("Palisade Peach Shack")    
    vendor_3.stock("Peaches", 65)    
    market.add_vendor(vendor_1)    
    market.add_vendor(vendor_2)    
    market.add_vendor(vendor_3)
    expected = [vendor_1, vendor_3]
    assert_equal expected, market.vendors_that_sell("Peaches")

    expected = [vendor_2]
    assert_equal expected, market.vendors_that_sell("Banana Nice Cream")
  end

end
