Rails.application.config.sorcery.submodules = [:core, :user_activation, :reset_password, :remember_me, :session_timeout, :activity_logging]

Rails.application.config.sorcery.configure do |config|
  config.session_timeout = 10.minutes
  config.session_timeout_from_last_action = true

  config.user_config do |user|
    user.username_attribute_names = :email
    user.downcase_username_before_authenticating = true
    user.user_activation_mailer = UserMailer

    user.reset_password_mailer = UserMailer
    user.reset_password_time_between_emails = nil

    # TODO: bug. active users counts for the last 25 minutes
    user.activity_timeout = 25.minute
  end

  config.user_class = 'User'
end
