class Event < ActiveRecord::Base
  has_many :attendances, dependent: :destroy
  has_many :attenders, through: :attendances, source: :user
end
