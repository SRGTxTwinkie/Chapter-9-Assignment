class Product
  attr_accessor :productNumber, :quantityOnHand, :retail
  def initialize(productNumber, description, cost, quantityOnHand)
    @productNumber = productNumber
    @description = description
    @cost = cost.to_f.round(2)
    @retail = cost * 3.round(2)
    @quantityOnHand = quantityOnHand
    QuantityCheck()
  end

  def Display()
    puts
    puts "INFORMATION FOR PRODUCT #{@productNumber}"
    puts "Product #{@productNumber}: #{@description}."
    puts "This product cost $#{@cost}."
    puts "This product retails for $#{@retail}."
    puts "We have #{@quantityOnHand} in store now."
  end

  def QuantityCheck
    puts
    if @quantityOnHand.to_i <= 0
      print "Sorry, I'm not sure why we would have ordered Zero product. \n"
      print "How about we pust something that is more than Zero? \n"
      print "Quantity: "
      x = gets.to_i
      if x <= 0
        puts "Come on son"
        QuantityCheck()
      else
        @quantityOnHand = x
      end
    end
  end
end
