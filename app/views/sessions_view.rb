class SessionsView
  def ask_for(stuff)
    puts "What is your #{stuff}?"
    print '> '
    gets.chomp
  end
end
