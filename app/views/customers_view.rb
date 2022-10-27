class CustomersView
  def ask_user_for(stuff)
    puts ''
    puts("What is the #{stuff}?")
    print '> '
    words = gets.chomp.split
    words.map { |word| word.capitalize }.join(' ')
  end

  def display(customers)
    puts ''
    puts 'Customers:'
    customers.each_with_index do |customer, index|
      puts "#{index + 1} - #{customer.name} - #{customer.address}"
    end
  end
end
