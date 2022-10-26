require 'csv'
require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file)
    @employees = []
    @csv_file = csv_file
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def create(employee)
    employee.id = @next_id
    @employees << employee
    @next_id += 1
    save_csv
  end

  def all
    @employees
  end

  def all_drivers
    @employees.select { |employee| employee.role == 'driver' }
  end

  def find(index)
    @employees.find { |employee| employee.id == index }
  end

  def find_by_username(username)
    @employees.find { |employee| employee.username == username }
  end

  private

  def load_csv
    @employees = []
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      @employees << Employee.new(row)
    end
    @next_id = @employees.last.id + 1 unless @employees.empty?
  end

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << %w[id username password role]
      @employees.each do |employee|
        csv << [employee.id, employee.username, employee.password, employee.role]
      end
    end
  end
end

# EMPLOYEE_CSV_FILE = File.join(__dir__, '../data/employee.csv')
# EMPLOYEE_CSV_FILE = '/Users/lingfungc/code/lingfungc/food_delivery/data/employee.csv'

# employee_repo = EmployeeRepository.new(EMPLOYEE_CSV_FILE)

# p employee_repo

# p employee_repo.all_riders

# p employee_repo.find(2)

# p employee_repo.find_by_username('Justin')
