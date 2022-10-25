class OrdersView
  def ask_user_for(stuff)
    puts("What is the #{stuff}?")
    print '> '
    gets.chomp.capitalize
  end

  def display(orders)
    puts '----------'
    puts 'Orders:'
    orders.each_with_index do |order, index|
      puts "#{index + 1} - #{order.meal.name} to #{order.customer.name} by #{order.employee.username}"
    end
  end
end
