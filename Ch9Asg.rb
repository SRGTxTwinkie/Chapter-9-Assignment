require_relative 'Product'

$items = []
$productNumbers = []

$items.append(Product.new('0000',"Default Item",3.50, 999))
$productNumbers.append('0000')

class Receipt
  def initialize(item)
    @item = item
    @subtotal = 0
    @salesTax = 0
    @total = 0
    for i in $items
      if i.productNumber == item
        @subtotal = i.retail
        @salesTax = i.retail * 0.6
        @total = @subtotal + @salesTax
      else
        next
      end
    end
  end

  def Display
    puts
    print "Your subtotal is $#{@subtotal} \n"
    print "Your sales tax is $#{@salesTax} \n"
    print "The total of your purchase is $#{@total} \n"
  end
end

def Menu
  puts
  puts "1:) New Item"
  puts "2:) Item Lookup"
  puts "3:) Product Purchase"
  print "[1/2/3]: "
  choice = gets.chomp
  if choice == "1"
    Newitem()
  elsif choice == "2"
    Lookup()
  elsif choice == "3"
    Purchase()
  else
    Menu()
  end
end

def Purchase
  puts
  for i in $items
    i.Display
    puts
  end

  print "Please enter the item number for your purchase: "
  itemP = gets.chomp

  conf = ""
  until conf == "Y" or conf == "N"
    print "Does this look right?: \n"

    for i in $items
      if i.productNumber == itemP
        currentItem = i
        i.Display
      else
        next
      end
    end
    print "[Y/N]: "
    conf = gets.chomp.upcase
  end

  if conf == "Y"
    print "How many would you like to purchase?: "
    itemnum = gets.to_i
    if itemnum > currentItem.quantityOnHand
      puts "Sorry, we dont have that many in stock"
      Purchase()
    else
      receipt = Receipt.new(itemP)
    end

  else
    Purchase()
  end

  print receipt.Display

  currentItem.quantityOnHand -= itemnum

  Menu()
end

def Lookup()
  puts
  print "What is the product number you are looking for?: "
  number = gets.chomp
  x = 0
  for i in $productNumbers
    if i == number
      break
    else
      x += 1
      next
    end
  end
  begin
    print $items[x].Display
  rescue
    puts "Sorry, that item couldn't be found."
  end

  Menu()

end

def Newitem()
  puts
  print "Please enter a product number: "
  productNumber = gets.chomp
  for i in $productNumbers
    if i == productNumber
      print "That has already been taken \n"
      Newitem()
    else
      next
    end
  end
  $productNumbers.append(productNumber)

  print "Please enter a breif product description: "
  description = gets.chomp

  print "How much does the item cost: "
  cost = gets.to_i

  print "The usual markup rate is 300% \n"

  print "How many do we have in store?: "
  quantity = gets

  $items.append(Product.new(productNumber, description, cost, quantity))
  Menu()
end

Menu()
