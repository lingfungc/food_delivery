class SessionsView
  def ask_for(stuff)
    puts ''
    puts "What is your #{stuff}?"
    print '> '
    gets.chomp
  end

  def display(employees)
    puts ''
    puts 'Drivers:'
    employees.each_with_index do |employee, index|
      puts "#{index + 1} - #{employee.username}"
    end
  end

  def signed_in(employee)
    print `clear`
    puts "Welcome #{employee.role.capitalize} #{employee.username.capitalize}"
  end

  def wrong_credentials
    print `clear`
    puts 'Wrong credentials. Please try again.'
  end
end
