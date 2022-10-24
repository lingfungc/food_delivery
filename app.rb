require_relative 'app/repositories/meal_repository.rb'
require_relative 'router.rb'

# __dir__ = file path of current directory = /Users/xxx/code/xxx/food_delivery/
MEALS_CSV_FILE = File.join(__dir__, 'data/meal.csv')

meal_repo = MealRepository.new(MEALS_CSV_FILE)

router = Router.new()
router.run
