class CustomersView
  def ask_user_for(stuff)
    puts("What is the #{stuff}?")
    print '> '
    gets.chomp.capitalize
  end

  def display(customers)
    puts 'Customers:'
    customers.each_with_index do |customer, index|
      puts "#{index + 1} - #{customer.name} at #{customer.address}"
    end
  end
end
