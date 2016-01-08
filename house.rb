class House
  attr_reader :square_feet, :num_bedrooms, :num_baths, :cost

  def initialize(address, square_feet, num_bedrooms = 3, num_baths = 2, cost = 320_000, down_payment = 0.20, sold = false, has_tenants = false)
    @address = address
    @square_feet = square_feet
    @num_bedrooms = num_bedrooms
    @num_baths = num_baths
    @cost = cost
    @down_payment = down_payment
    @sold = sold
    @has_tenants = has_tenants
  end

  def obscure_address
    @address.sub(/\A\d*/, '****')
  end

  def buy!(money, good_credit)
    @sold = true if money >= down_payment && good_credit
  end

  def down_payment
    cost * @down_payment
  end

  def to_s
    "#{obscure_address} : #{square_feet} sq. ft., #{num_bedrooms} bed, #{num_baths} bath. $#{cost}"
  end
end
