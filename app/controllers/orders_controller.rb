require_relative '../models/order'
require_relative '../views/orders_view'

class OrdersController
  def initialize(order_repository)
    @order_repository = order_repository
    @orders_view = OrdersView.new
  end

  def add
    meal = @orders_view.ask_user_for(:meal)
    customer = @orders_view.ask_user_for(:customer)
    employee = @orders_view.ask_user_for(:employee)
    order = order.new(name: name, price: price)
    @order_repository.create(order)
    display_orders
  end

  def list
    display_orders
  end

  def edit
    display_orders
    id = @orders_view.ask_user_for(:id).to_i
    meal = @orders_view.ask_user_for(:meal)
    customer = @orders_view.ask_user_for(:customer)
    employee = @orders_view.ask_user_for(:employee)
    order = @order_repository.find(id)
    @order_repository.update(order, meal, customer, employee)
    display_orders
  end

  def destory
    display_orders
    id = @orders_view.ask_user_for(:id).to_i
    @order_repository.delete(id)
    display_orders
  end

  private

  def display_orders
    orders = @order_repository.all
    @orders_view.display(orders)
  end

  def display_undelivered_orders
    orders = @order_repository.undelivered_orders
    @orders_view.display(orders)
  end

end
