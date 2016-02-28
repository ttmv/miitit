class User < ActiveRecord::Base
  validates :username, uniqueness: true
  has_many :attendances, dependent: :destroy
  has_many :events, through: :attendances
end
