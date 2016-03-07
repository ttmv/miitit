class User < ActiveRecord::Base
  validates :username, uniqueness: true, length: { minimum: 1 }
  validates :password, length: { minimum: 6 }, on: :create
  has_secure_password
  has_many :attendances, dependent: :destroy
  has_many :events, through: :attendances
  has_many :messages, dependent: :destroy
  
  has_many :admin_attendances, -> { where admin:true }, class_name: "Attendance"
  has_many :adminstrated_events, through: :admin_attendances, source: :event
  
  def to_s
    return "#{self.username}"
  end
  
  def only_admin
    self.adminstrated_events.each{|e| e.admins.count == 1 }.count > 0 
  end
end
