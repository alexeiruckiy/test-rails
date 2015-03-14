class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  DEFAULT_ROLE = 'guest'
end
