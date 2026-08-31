# app/mailers/recipe_mailer.rb
class RecipeMailer < ApplicationMailer
  def share(recipe, recipient, sender_email = nil)
    @recipe = recipe
    @sender_email = sender_email

    @heading =
      (
        if @sender_email
          "#{@sender_email} has shared a recipe with you"
        else
          "Someone has shared a recipe with you"
        end
      )

    mail to: recipient, subject: @heading
  end
end
