require_relative '../models/order'
require_relative '../views/orders_view'
require_relative '../views/meals_view'
require_relative '../views/customers_view'
require_relative '../views/sessions_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @order_repository = order_repository
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders_view = OrdersView.new
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @sessions_view = SessionsView.new
  end

  def add
    meal = select_meal
    customer = select_customer
    employee = select_employee
    order = Order.new(meal: meal, customer: customer, employee: employee)
    @order_repository.create(order)
    display_orders
  end

  def list
    display_orders
  end

  def edit
    display_orders
    index = @orders_view.ask_user_for(:index).to_i
    meal = select_meal
    customer = select_customer
    employee = select_employee
    order = @order_repository.find(index)
    # p order
    @order_repository.update(order, meal, customer, employee)
    display_orders
  end

  def destory
    display_orders
    index = @orders_view.ask_user_for(:index).to_i
    @order_repository.delete(index)
    display_orders
  end

  def list_undelivered_orders
    undelivered_orders = @order_repository.undelivered_orders
    @orders_view.display(undelivered_orders)
  end

  def list_my_orders(current_user)
    list_my_undelivered_orders(current_user)
  end

  def mark_as_delivered(current_user)
    list_my_undelivered_orders(current_user)
    index = @orders_view.ask_user_for(index).to_i
    # my_orders = @order_repository.my_undelivered_orders(current_user)
    order = @order_repository.find(index)
    @order_repository.mark_as_delivered(order)
  end

  private

  def select_meal
    meals = @meal_repository.all
    @meals_view.display(meals)
    index = @orders_view.ask_user_for(:index).to_i
    # p meals[index - 1]
    return meals[index - 1]
    # @meal_repository.find(index)
  end

  def select_customer
    customers = @customer_repository.all
    @customers_view.display(customers)
    index = @orders_view.ask_user_for(:index).to_i
    # p customers[index - 1]
    return customers[index - 1]
    # @customer_repository.find(index)
  end

  def select_employee
    employees = @employee_repository.all_drivers
    @sessions_view.display(employees)
    index = @orders_view.ask_user_for(:index).to_i
    # p employees
    # p employees[index - 1]
    return employees[index - 1]
    # @employee_repository.find(index)
  end

  def display_orders
    orders = @order_repository.all
    @orders_view.display(orders)
  end

  def display_undelivered_orders
    orders = @order_repository.undelivered_orders
    @orders_view.display(orders)
  end

  def list_my_undelivered_orders(user)
    orders = @order_repository.my_undelivered_orders(user)
    @orders_view.display(orders)
  end
end
