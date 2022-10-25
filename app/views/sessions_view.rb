class SessionsView
  def ask_for(stuff)
    puts "What is your #{stuff}?"
    print '> '
    gets.chomp
  end

  def signed_in(employee)
    puts "Welcome #{employee.role.capitalize} #{employee.username.capitalize}"
  end

  def wrong_credentials
    puts 'Wrong credentials. Please try again'
  end
end
