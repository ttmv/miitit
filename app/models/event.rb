class Event < ActiveRecord::Base
  validates :name, length: { minimum: 1 }

  has_many :attendances, dependent: :destroy
  has_many :attenders, through: :attendances, source: :user
  has_many :messages, dependent: :destroy
  
  has_many :admin_attendances, -> { where admin:true }, class_name: "Attendance"
  has_many :admins, through: :admin_attendances, source: :user
  
  def to_s
    return "#{self.name}"
  end
  
  def event_date
    return "#{self.time.day}.#{self.time.month}.#{self.time.year}"
  end
  
  def event_time
    return "#{self.time.hour}:#{self.time.min}"
  end

end
