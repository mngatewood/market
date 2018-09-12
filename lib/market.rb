require 'pry'

class Market

  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    return @vendors.map{|vendor|vendor.name}
  end

  def vendors_that_sell(product)
    return @vendors.find_all do |vendor|
      vendor.inventory.keys.include?(product)
    end
  end

  def sorted_item_list
    all_products = @vendors.map{|vendor|vendor.inventory.keys}.flatten
    unique_products = all_products.uniq
    return unique_products.sort
  end

  def total_inventory
    total_inventory = Hash.new(0)
    vendors.each do |vendor|
      vendor.inventory.keys.each do |product|
        total_inventory[product] += vendor.inventory[product]
      end
    end
    return total_inventory
  end

end