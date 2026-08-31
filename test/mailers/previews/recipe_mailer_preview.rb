# Preview all emails at http://localhost:3000/rails/mailers/recipe_mailer
class RecipeMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/recipe_mailer/share
  def share
    recipe = Recipe.new(id: 1, title: "Fluffy pancakes")
    sender = "alice@example.com"

    RecipeMailer.share(recipe, "friend@example.com", sender)
  end

  # Preview this email at http://localhost:3000/rails/mailers/recipe_mailer/share_by_guest
  def share_by_guest
    recipe = Recipe.new(id: 1, title: "Fluffy pancakes")

    RecipeMailer.share(recipe, "friend@example.com")
  end
end
