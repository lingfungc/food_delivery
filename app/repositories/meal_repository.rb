require 'csv'
require_relative '../models/meal'

class MealRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @meals = []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def create(meal)
    meal.id = @next_id
    @meals << meal
    @next_id += 1
    save_csv
  end

  def all
    @meals
  end

  def find(id)
    @meals.find { |meal| meal.id == id + 1 }
  end

  def update(meal, name, price)
    meal.name = name
    meal.price = price
    save_csv
  end

  def delete(id)
    @meals.delete_at(id)
    save_csv
    load_csv
  end

  private

  def load_csv
    @meals = []
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      @meals << Meal.new(row)
    end
    @next_id = @meals.empty? ? 1 : @meals.last.id + 1
  end

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << %w[id name price]
      @meals.each_with_index do |meal, index|
        csv << [index + 1, meal.name, meal.price]
      end
    end
  end
end
