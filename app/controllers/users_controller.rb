class UsersController < ApplicationController
  # TODO: bug. impossible to show user details for unauthorized, but online list is present on home page and links are active
  before_filter :require_login, :except => [:create, :new, :activate]

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @title = t('app_name') + " | #{@user.fname} #{@user.lname}"

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    @btn_text = t('users.new.btn_signup')
    @title = t('app_name') + ' | ' + t('users.new.title')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
    @btn_text = t('users.edit.btn_update')
    @title = t('app_name') + " | #{@user.fname} #{@user.lname}"
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { flash.now[:info] = t('users.create.success'); redirect_to root_path }
        format.json { render json: @user, status: :created, location: @user }
      else
        @btn_text = t('users.new.btn_signup')
        @user.password = ''
        @user.password_confirmation = ''
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { flash[:notice] = t('users.update.success'); redirect_to @user }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  # TODO: bug. impossible to delete user from service. no view.
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def activate
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      flash[:notice] = t('users.activate.success')
      redirect_to(login_path)
    else
      not_authenticated
    end
  end

  def not_authenticated
    flash.now[:alert] = t('users.alert_login')
    redirect_to(root_path)
  end

  def current_user?(user)
    return user.email == current_user.email
  end
end
