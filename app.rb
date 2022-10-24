require_relative 'app/repositories/meal_repository'
require_relative "app/controllers/meals_controller"
require_relative 'router'

# __dir__ = file path of current directory = /Users/xxx/code/xxx/food_delivery/
MEALS_CSV_FILE = File.join(__dir__, 'data/meals.csv')

meal_repo = MealRepository.new(MEALS_CSV_FILE)
meals_controller = MealsController.new(meal_repo)

router = Router.new(meals_controller)
router.run
