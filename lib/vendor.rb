class Vendor

  attr_reader :name,
              :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(product)
    return inventory[product]
  end

  def stock(product, quantity)
    @inventory[product] += quantity
  end

  def sell(product, quantity)
    if inventory[product] >= quantity 
      @inventory[product] -= quantity
    end
  end

end