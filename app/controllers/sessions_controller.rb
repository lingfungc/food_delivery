class SessionsController
  def initialize
    @sessions_view = SessionsView.new
  end

  def login
    # ask username and password
    username = @sessions_view.ask_for(username)
    password = @sessions_view.ask_for(password)

    # check the employee repository if the username exist?

    # check the password
      # log in and give them a welcome message
      # wrong credentials and try again
  end
end
