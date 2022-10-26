class Employee
  attr_accessor :id, :password
  attr_reader :username, :role

  def initialize(attributes = {})
    @id = attributes[:id]
    @username = attributes[:username]
    @password = attributes[:password]
    @role = attributes[:role]
  end

  def manager?
    @role == 'manager'
  end

  def driver?
    @role == 'driver'
  end
end
