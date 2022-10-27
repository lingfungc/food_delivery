class OrdersView
  def ask_user_for(stuff)
    puts ''
    puts("What is the #{stuff}?")
    print '> '
    words = gets.chomp.split
    words.map { |word| word.capitalize }.join(' ')
  end

  def display(orders)
    puts ''
    puts 'Orders:'
    orders.each_with_index do |order, index|
      if order.delivered?
        # puts order.meal
        # puts order.customer
        # puts order.employee
        puts "#{index + 1} - *DELIVERED* #{order.meal.name} - #{order.customer.name} | delivered by #{order.employee.username}"
      else
        # puts order.meal
        # puts order.customer
        # puts order.employee
        puts "#{index + 1} - #{order.meal.name} - #{order.customer.name} | delivered by #{order.employee.username}"
      end
    end
  end
end
