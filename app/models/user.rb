class User < ActiveRecord::Base
  validates :username, uniqueness: true, length: { minimum: 1 }
  has_secure_password
  has_many :attendances, dependent: :destroy
  has_many :events, through: :attendances
end
