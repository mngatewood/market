require 'minitest/autorun'
require 'minitest/pride'
require './lib/market.rb'
require './lib/vendor.rb'

class MarketTest < Minitest::Test

  def setup
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor_1 = Vendor.new("Rocky Mountain Fresh")
    @vendor_1.stock("Peaches", 35)    
    @vendor_1.stock("Tomatoes", 7)    
    @vendor_2 = Vendor.new("Ba-Nom-a-Nom")    
    @vendor_2.stock("Banana Nice Cream", 50)    
    @vendor_2.stock("Peach-Raspberry Nice Cream", 25)    
    @vendor_3 = Vendor.new("Palisade Peach Shack")    
    @vendor_3.stock("Peaches", 65)    
    @market.add_vendor(@vendor_1)    
    @market.add_vendor(@vendor_2)    
    @market.add_vendor(@vendor_3)
  end

  def test_it_exists
    assert_instance_of Market, @market
  end

  def test_it_takes_arguments
    assert_equal "South Pearl Street Farmers Market", @market.name
  end

  def test_it_starts_with_no_vendors
    market = Market.new("South Pearl Street Farmers Market")
    assert_equal [], market.vendors
    assert_instance_of Array, @market.vendors
  end

  def test_it_adds_vendors_to_vendors_array
    expected = [@vendor_1, @vendor_2, @vendor_3]
    assert_equal expected, @market.vendors
  end

  def test_it_returns_names_of_all_vendors_in_market
    expected = ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"]
    assert_equal expected, @market.vendor_names
  end

  def test_it_returns_all_vendors_that_sell_a_given_product
    expected = [@vendor_1, @vendor_3]
    assert_equal expected, @market.vendors_that_sell("Peaches")

    expected = [@vendor_2]
    assert_equal expected, @market.vendors_that_sell("Banana Nice Cream")
  end

  def test_it_returns_a_sorted_array_of_all_in_stock_products
    expected = ["Banana Nice Cream", "Peach-Raspberry Nice Cream", "Peaches", "Tomatoes"]
    assert_equal expected, @market.sorted_item_list
  end

  def test_it_returns_a_hash_of_all_products
    expected = {"Peaches"=>100, "Tomatoes"=>7, "Banana Nice Cream"=>50, "Peach-Raspberry Nice Cream"=>25}
    assert_equal expected, @market.total_inventory
  end

  def test_it_returns_false_if_not_enough_stock_to_sell_product
    refute @market.sell("Peaches", 200)
    refute @market.sell("Onions", 1)
    assert @market.sell("Banana Nice Cream", 5)
  end

  def test_it_reduces_stock_for_each_vendor_in_market_until_all_sold
    assert @market.sell("Banana Nice Cream", 5)
    assert_equal 45, @vendor_2.check_stock("Banana Nice Cream")

    assert @market.sell("Peaches", 40)
    assert_equal 0, @vendor_1.check_stock("Peaches")
    assert_equal 60, @vendor_3.check_stock("Peaches")
  end

end
