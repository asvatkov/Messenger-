class UserMailer < ActionMailer::Base
  # TODO: bug. mail from different domain.
  default from: 'info@messenger_minus.com'

  def activation_needed_email(user)
    @user = user
    @url  = activate_user_url(user.activation_token)
    mail(:to => user.email,
         :subject => t('user_mailer.activation_needed.subject'))
  end

  def activation_success_email(user)
    @user = user
    @url  = login_url
    # TODO: bug. only this subject ends with point
    mail(:to => user.email,
         :subject => t('user_mailer.activation_success.subject'))
  end

  def reset_password_email(user)
    @user = user
    @url  = edit_password_reset_url(user.reset_password_token)
    mail(:to => user.email,
         :subject => t('user_mailer.reset_password.subject'))
  end
end
