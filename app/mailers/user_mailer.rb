class UserMailer < ActionMailer::Base
  default from: 'info@messenger_minus.com'

  def activation_needed_email(user)
    @user = user
    @url  = "http://http://messenger-minus.herokuapp.com//users/#{user.activation_token}/activate"
    mail(:to => user.email,
         :subject => "Welcome to My Awesome Site")
  end

  def activation_success_email(user)
    @user = user
    @url  = "http://http://messenger-minus.herokuapp.com//login"
    mail(:to => user.email,
         :subject => "Your account is now activated")
  end

  def reset_password_email(user)
    @user = user
    @url  = "http://http://messenger-minus.herokuapp.com//password_resets/#{user.reset_password_token}/edit"
    mail(:to => user.email,
         :subject => "Your password reset request")
  end
end
