class SessionsController < ApplicationController
  skip_before_filter :require_login, :except => [:destroy]

  def new
    @user = User.new
    @title = t('app_name') + ' | ' + t('sessions.new.title')
  end

  def create
    respond_to do |format|
      if @user = login(params[:email],params[:password],params[:remember])
        format.html { redirect_back_or_to(:root) }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { flash.now[:alert] = t('sessions.login_failed'); render :action => 'new' }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    logout
    flash.now[:alert] = t('sessions.logged_out')
    redirect_to(:root)
  end
end
