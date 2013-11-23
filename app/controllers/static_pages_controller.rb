class StaticPagesController < ApplicationController
  before_filter :require_login, :except => [:current_users_list, :home]

  helper_method :current_users_list

  def home
  end

  def current_users_list
    current_users.map {|u| u.fname + ' ' + u.lname}.join(', ')
  end
end
