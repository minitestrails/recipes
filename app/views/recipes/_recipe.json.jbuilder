json.extract! recipe, :id, :title, :description, :prep_time, :servings, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
