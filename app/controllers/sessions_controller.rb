require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @sessions_view = SessionsView.new
    @employee_repository = employee_repository
  end

  def login
    # ask username and password
    username = @sessions_view.ask_for(:username)
    password = @sessions_view.ask_for(:password)

    # check the employee repository if the username exist?
    employee = @employee_repository.find_by_username(username)

    # check the password
    if employee && employee.password == password
      # log in and give them a welcome message
      @sessions_view.signed_in(employee)
    else
      # wrong credentials and try again
      @sessions_view.wrong_credentials
      login
    end
  end
end
