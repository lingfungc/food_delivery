require_relative 'app/repositories/meal_repository'
require_relative 'app/controllers/meals_controller'
require_relative 'app/repositories/customer_repository'
require_relative 'app/controllers/customers_controller'
require_relative 'app/controllers/sessions_controller'
require_relative 'router'

# __dir__ = file path of current directory = /Users/xxx/code/xxx/food_delivery/
MEALS_CSV_FILE = File.join(__dir__, 'data/meals.csv')
CUSTOMERS_CSV_FILE = File.join(__dir__, 'data/customers.csv')

meal_repo = MealRepository.new(MEALS_CSV_FILE)
meals_controller = MealsController.new(meal_repo)
customer_repo = CustomerRepository.new(CUSTOMERS_CSV_FILE)
customers_controller = CustomersController.new(customer_repo)
sessions_controller = SessionsController.new

router = Router.new(meals_controller, customers_controller, sessions_controller)
router.run
