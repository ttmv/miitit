class Event < ActiveRecord::Base
  validates :name, length: { minimum: 1 }

  has_many :attendances, dependent: :destroy
  has_many :attenders, through: :attendances, source: :user
  
  has_many :admin_attendances, -> { where admin:true }, class_name: "Attendance"
  has_many :admins, through: :admin_attendances, source: :user
end
