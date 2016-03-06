class User < ActiveRecord::Base
  validates :username, uniqueness: true, length: { minimum: 1 }
  has_secure_password
  has_many :attendances, dependent: :destroy
  has_many :events, through: :attendances
  has_many :messages, dependent: :destroy
  
  has_many :admin_attendances, -> { where admin:true }, class_name: "Attendance"
  has_many :adminstrated_events, through: :admin_attendances, source: :event
end
