class Entity < ActiveRecord::Base
  has_many :users
  has_many :validations
end
