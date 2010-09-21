class Reminder < ActiveRecord::Base
  validates_presence_of :phone_number

  ACCOUNT_SID   = 'ACXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
  ACCOUNT_TOKEN = 'YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY'
  CALLER_ID     = 'NNNNNNNNNN'
  API_VERSION   = '2010-04-01'

  
  def notify_of_succesful_subscription
    message = {
      :from => CALLER_ID,
      :to   => self.phone_number,
      :body => "Thanks for subscribing! You'll be reminded to vote once per day until the contest ends."
    }
    
    account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)
    resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/SMS/Messages", "POST", message)
    resp.error! unless resp.kind_of? Net::HTTPSuccess
    resp
  end 
  alias :notify_of_succesful_subscription :notify_already_subscribed


end
