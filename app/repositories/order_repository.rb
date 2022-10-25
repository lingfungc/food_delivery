require 'csv'
require_relative '../models/order'

class OrderRepository
  def initialize(csv_file, meal_repository, customer_repository, employee_repository)
    @orders = []
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @csv_file = csv_file
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  private

  def load_csv
    @orders = []
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      row[:delivered] = row[:delivered] == 'true'
      row[:meal] = @meal_repository.find(row[:meal_id].to_i)
      row[:customer] = @customer_repository.find(row[:customer_id].to_i)
      row[:employee] = @employee_repository.find(row[:employee_id].to_i)
      @orders << Order.new(row)
    end
    @next_id = @orders.empty? ? 1 : @orders.last.id + 1
  end

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << %w[id delivered meal_id customer_id employee_id]
      @orders.each_with_index do |order, index|
        csv << [index + 1, order.delivered, order.meal_id, order.customer_id, order.employee_id]
      end
    end
  end
end
