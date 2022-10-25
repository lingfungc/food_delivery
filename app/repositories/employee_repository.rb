require 'csv'
require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file)
    @employees = []
    @csv_file = csv_file
    load_csv if File.exist?(@csv_file)
  end

  def all_riders
    @employees.select { |employee| employee.role == 'rider' }
  end

  def find(id)
    @employees.find { |employee| employee.id == id }
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
  end
end

# EMPLOYEE_CSV_FILE = File.join(__dir__, '../data/employee.csv')
EMPLOYEE_CSV_FILE = '/Users/lingfungc/code/lingfungc/food_delivery/data/employee.csv'

employee_repo = EmployeeRepository.new(EMPLOYEE_CSV_FILE)

p employee_repo

p employee_repo.all_riders

p employee_repo.find(2)

p employee_repo.find_by_username('Justin')
