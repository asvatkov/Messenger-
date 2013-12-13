class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.json
  def inbox
    @messages = Message.where(:to => current_user.email).order_by([:created_at, :desc])
    @title = t('app_name') + ' | ' + t('messages.inbox.title')

    respond_to do |format|
      format.html # inbox.html.erb
      format.json { render json: @messages }
    end
  end

  def outbox
    # TODO: bug. messages incorrectly ordered
    @messages = Message.where(:from => current_user.email)#.order_by([:created_at, :desc])
    @title = t('app_name') + ' | ' + t('messages.outbox.title')

    respond_to do |format|
      format.html # outbox.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])
    @message.update_attributes!(:unread => false) if (@message.to == current_user.email)
    @from = User.where(:email => @message.from).first
    @title = t('app_name') + ' | ' + t('messages.show.title')

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new
    @reply_to = params[:reply_to]
    @title = t('app_name') + ' | ' + t('messages.new.title')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(params[:message])
    @message.from = current_user.email

    respond_to do |format|
      if @message.save
        format.html { redirect_to inbox_url, notice: t('messages.create.notice') }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.to == current_user.email
        @message.destroy
        format.html { redirect_to inbox_url }
        format.json { head :no_content }
      else
        format.html { redirect_to inbox_url, error: t('messages.destroy.error') }
        format.json { head :no_content }
      end
    end
  end
end
