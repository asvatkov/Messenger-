class StaticPagesController < ApplicationController
  before_filter :require_login, :except => [:current_users_list, :home]

  helper_method :current_users_list, :active_users

  def home
    respond_to do |format|
      format.html
    end
  end

  def current_users_list
    current_users.map {|u| u.fname + ' ' + u.lname}.join(', ')
  end

  def active_users
    current_users
  end
end
