class OrdersView
  def ask_user_for(stuff)
    puts("What is the #{stuff}?")
    print '> '
    gets.chomp.capitalize
  end
end

class MealsView
  def ask_user_for(stuff)
    puts("What is the #{stuff}?")
    print '> '
    gets.chomp.capitalize
  end

  def display(meals)
    meals.each_with_index do |meal, index|
      puts "#{index + 1} - #{meal.name} £#{meal.price}"
    end
  end
end
