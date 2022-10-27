require 'BCrypt'

class User
  attr_reader :username
  attr_accessor :password

  def initialize(attributes = {})
    @username = attributes[:username]
    @password = attributes[:password]
  end

  # def update_attribute(key, value)
  #   p self
  # end
end

user = User.new(username: 'Jay', password: '123456')

# hash a user's password
password = BCrypt::Password.create("my grand secret")
p password #=> "$2a$12$C5.FIvVDS9W4AYZ/Ib37YuWd/7ozp1UaMhU28UKrfSxp2oDchbi3K"

p user

# store it safely
user.password = password

p user

# read it back
# user.reload!
db_password = BCrypt::Password.new(user.password)

# compare it after retrieval
p db_password == "my grand secret" #=> true
p db_password == "a paltry guess"  #=> false
