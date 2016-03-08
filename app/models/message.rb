class Message < ActiveRecord::Base
  validates :user_id, presence: true
  validates :event_id, presence: true #but event does not need to exist yet... #TODO: fix
  
  belongs_to :user
  belongs_to :event
  
  def time
    return self.timestamp.strftime("%d.%m.%Y %H:%M")
  end
end
