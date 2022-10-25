require 'csv'
require_relative '../models/customer'

class CustomerRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @customers = []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def create(customer)
    customer.id = @next_id
    @customers << customer
    @next_id += 1
    save_csv
  end

  def all
    @customers
  end

  def find(index)
    @customers.find { |customer| customer.id == index }
  end

  def update(customer, name, address)
    customer.name = name
    customer.address = address
    save_csv
    load_csv
  end

  def delete(index)
    @customers.delete_at(index - 1)
    save_csv
    load_csv
  end

  private

  def load_csv
    @customers = []
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      @customers << Customer.new(row)
    end
    @next_id = @customers.empty? ? 1 : @customers.last.id + 1
  end

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << %w[id name address]
      @customers.each_with_index do |customer, index|
        csv << [index + 1, customer.name, customer.address]
      end
    end
  end
end
