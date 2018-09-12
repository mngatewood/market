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

end