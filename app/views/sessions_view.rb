class SessionsView
  def ask_for(stuff)
    puts "What is your #{stuff}?"
    print '> '
    gets.chomp
  end

  def display(employees)
    puts '----------'
    puts 'Drivers:'
    employees.each_with_index do |employee, index|
      puts "#{index + 1} - #{employee.username}"
    end
  end

  def signed_in(employee)
    print `clear`
    puts "Welcome #{employee.role.capitalize} #{employee.username.capitalize}"
    puts ''
  end

  def wrong_credentials
    puts 'Wrong credentials. Please try again.'
    puts ''
  end
end
