class RemindersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create
  
  # GET /reminders
  # GET /reminders.xml
  def index
    phone_number = params["From"]
    @reminder = Reminder.find_by_phone_number(phone_number)
    raise phone_number.inspect
    
    if @reminder
      @reminder.notify_already_subscribed
    else
      raise "you win!"
#      create # Twilio doesn't seem to actually do REST posting
    end 
    
#     respond_to do |format|
#       format.html # index.html.erb
#       format.xml  { render :xml => @reminders }
#     end
  end

  # GET /reminders/1
  # GET /reminders/1.xml
  def show
    @reminder = Reminder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reminder }
    end
  end

  # GET /reminders/new
  # GET /reminders/new.xml
  def new
    @reminder = Reminder.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reminder }
    end
  end

  # GET /reminders/1/edit
  def edit
    @reminder = Reminder.find(params[:id])
  end

  # POST /reminders
  # POST /reminders.xml
  def create
    @reminder   = Reminder.find_by_phone_number(params["From"])
    @reminder ||= Reminder.new(:phone_number => params["From"])
    
    respond_to do |format|
      if @reminder.save 
        @reminder.notify_of_succesful_subscription
#         format.html { redirect_to(@reminder, :notice => 'Reminder was successfully created.') }
#         format.xml  { render :xml => @reminder, :status => :created, :location => @reminder }
#       else
#         format.html { render :action => "new" }
#         format.xml  { render :xml => @reminder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reminders/1
  # PUT /reminders/1.xml
  def update
    @reminder = Reminder.find(params[:id])

    respond_to do |format|
      if @reminder.update_attributes(params[:reminder])
        format.html { redirect_to(@reminder, :notice => 'Reminder was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reminder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reminders/1
  # DELETE /reminders/1.xml
  def destroy
    @reminder = Reminder.find(params[:id])
    @reminder.destroy

    respond_to do |format|
      format.html { redirect_to(reminders_url) }
      format.xml  { head :ok }
    end
  end
end
