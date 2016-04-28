class Message < ActiveRecord::Base
  validates :user_id, presence: true
  validates :event_id, presence: true 
  
  belongs_to :user
  belongs_to :event
  
  def time
    return self.timestamp.strftime("%d.%m.%Y %H:%M")
  end
end
