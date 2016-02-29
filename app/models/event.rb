class Event < ActiveRecord::Base
  validates :name, length: { minimum: 1 }
  has_many :attendances, dependent: :destroy
  has_many :attenders, through: :attendances, source: :user
end
