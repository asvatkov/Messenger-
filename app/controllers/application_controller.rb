class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :require_login, :except => [:not_authenticated]

  def not_authenticated
    redirect_to root_path, :alert => t('error.not_logged_in')
  end
end
