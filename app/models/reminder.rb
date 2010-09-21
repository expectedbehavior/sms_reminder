class Reminder < ActiveRecord::Base
  validates_presence_of :phone_number
  
  def notify_already_subscribed
    raise "you're already subscribed!"
  end 



end
