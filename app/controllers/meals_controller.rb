require_relative '../models/meal'
require_relative '../views/meals_view'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def add
    name = @meals_view.ask_user_for(:name)
    price = @meals_view.ask_user_for(:price).to_f
    meal = Meal.new(name: name, price: price)
    @meal_repository.create(meal)
    display_meals
  end

  def list
    display_meals
  end

  def edit
    display_meals
    index = @meals_view.ask_user_for(:index).to_i
    name = @meals_view.ask_user_for(:name)
    price = @meals_view.ask_user_for(:price).to_f
    meal = @meal_repository.find(index)
    @meal_repository.update(meal, name, price)
    display_meals
  end

  def destory
    display_meals
    index = @meals_view.ask_user_for(:index).to_i
    @meal_repository.delete(index)
    display_meals
  end

  private

  def display_meals
    meals = @meal_repository.all
    @meals_view.display(meals)
  end
end
