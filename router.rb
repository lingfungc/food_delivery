class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    while @running
      @current_user = @sessions_controller.login
      # Avoid infinite loop of @sessions_controller.login
      while @current_user
      # check user is a manager or a driver
        if @current_user.manager?
          manager_menu
          choice = gets.chomp.to_i
          print `clear`
          manager_action(choice)
        else
          driver_menu
          choice = gets.chomp.to_i
          print `clear`
          driver_action(choice)
        end
      end
    end
  end

  private

  def manager_menu
    puts '----------------------------'
    puts '------- MANAGER MENU -------'
    puts '----------------------------'
    puts ''
    puts '1. Add new meal'
    puts '2. List all meals'
    puts '3. Edit a meal'
    puts '4. Delete a meal'
    puts '5. Add new customer'
    puts '6. List all customers'
    puts '7. Edit a customer'
    puts '8. Delete a customer'
    puts '9. Add new order'
    puts '10. List all orders'
    puts '11. List all undelivered orders'
    puts '12. Edit a order'
    puts '13. Delete a order'
    puts '14. Add a new driver'
    puts '15. List all drivers'
    puts '88. Logout'
    puts '0. Exit'
    print '> '
  end

  def manager_action(choice)
    case choice
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @meals_controller.edit
    when 4 then @meals_controller.destory
    when 5 then @customers_controller.add
    when 6 then @customers_controller.list
    when 7 then @customers_controller.edit
    when 8 then @customers_controller.destory
    when 9 then @orders_controller.add
    when 10 then @orders_controller.list
    when 11 then @orders_controller.list_undelivered_orders
    when 12 then @orders_controller.edit
    when 13 then @orders_controller.destory
    when 14 then @sessions_controller.add
    when 15 then @sessions_controller.list_drivers
    when 88 then logout!
    when 0 then stop!
    else puts 'Try again...'
    end
  end

  def driver_menu
    puts '---------------------------'
    puts '------- DRIVER MENU -------'
    puts '---------------------------'
    puts ''
    puts '1. Mark one of my orders as delivered'
    puts '2. List all my orders'
    puts '88. Logout'
    puts '0. Exit'
    print '> '
  end

  def driver_action(choice)
    case choice
    when 1 then @orders_controller.mark_as_delivered(@current_user)
    when 2 then @orders_controller.list_my_orders(@current_user)
    when 88 then logout!
    when 0 then stop!
    else puts 'Try again...'
    end
  end

  def logout!
    @current_user = nil
  end

  def stop!
    logout!
    @running = false
  end
end
