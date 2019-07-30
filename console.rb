require('pry-byebug')
require_relative('./models/property.rb')

Property.delete_all() 

property1 = Property.new(
  {
    'address' => '11 Renfrew Drive',
    'value' => 5500000,
    'number_of_bedrooms' => 1,
    'buy_let' => "t"
  }
)

property2 = Property.new(
  {
    'address' => '27 Willowbrook Estate',
    'value' => 100000,
    'number_of_bedrooms' => 16,
    'buy_let' => "f"
  }
)

property1.save()
property2.save()

# property1.delete()
property1.value = 6000000
property1.update()

binding.pry

nil
