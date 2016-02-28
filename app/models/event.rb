class Event < ActiveRecord::Base
  has_many :attendances
  has_many :attenders, through: :attendances, source: :user
end
