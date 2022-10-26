require 'BCrypt'
require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @sessions_view = SessionsView.new
    @employee_repository = employee_repository
  end

  def add
    username = @sessions_view.ask_for(:username)
    password = @sessions_view.ask_for(:password)
    # crypted the password when the employee enter his/her password
    password = BCrypt::Password.create(password)
    role = @sessions_view.ask_for(:role)
    # create the employee with the crypted password
    employee = Employee.new(username: username, password: password, role: role)
    @employee_repository.create(employee)
  end

  def list_drivers
    drivers = @employee_repository.all_drivers
    @sessions_view.display(drivers)
  end

  def login
    # Create an employee if there is no any employee
    add if @employee_repository.all.empty?

    username = @sessions_view.ask_for(:username)
    employee = @employee_repository.find_by_username(username)

    # if the employee exist then read the crypted password baack
    db_password = BCrypt::Password.new(employee.password) if employee

    # ask username and password
    password = @sessions_view.ask_for(:password)

    # check the read crypted password with the one the employee entered

    if employee && db_password == password
      # log in and give them a welcome message
      @sessions_view.signed_in(employee)
      employee
    else
      # wrong credentials and try again
      @sessions_view.wrong_credentials
      login
    end
  end
end
