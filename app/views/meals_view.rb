# Rake Error = Rake does not have puts '' and puts 'Meals'

class MealsView
  def ask_user_for(stuff)
    puts ''
    puts("What is the #{stuff}?")
    print '> '
    words = gets.chomp.split
    words.map { |word| word.capitalize }.join(' ')
  end

  def display(meals)
    puts ''
    puts 'Meals:'
    meals.each_with_index do |meal, index|
      puts "#{index + 1} - #{meal.name} - £#{meal.price}"
    end
  end
end
