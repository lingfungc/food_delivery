require 'csv'
require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file)
    @employees = []
    @csv_file = csv_file
    load_csv if File.exist?(@csv_file)
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
