# Preview all emails at http://localhost:3000/rails/mailers/passwords_mailer
class PasswordsMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/passwords_mailer/reset
  def reset
    user =
      User.new(
        email_address: "alice@example.com",
        password: "password",
        password_confirmation: "password"
      )

    PasswordsMailer.reset(user)
  end
end
