class Reminder < ActiveRecord::Base
  validates_presence_of :phone_number

  ACCOUNT_SID   = 'AC82cdf2260148c4b64a694548425f2b3f'
  ACCOUNT_TOKEN = '2c597425f56d6a3a1ee706e09dfa7a6d'
  CALLER_ID     = '3175271790'
  API_VERSION   = '2010-04-01'

  
  def notify_of_succesful_subscription
    message = "Thanks for subscribing! You'll be reminded to vote once per day until the contest ends."
    
    Twilio.connect(ACCOUNT_SID, ACCOUNT_TOKEN)
    Twilio::Sms.message(CALLER_ID, self.phone_number, message)    
  end 

end
