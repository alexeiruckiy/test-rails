class Role < ActiveRecord::Base
  DEFAULT_ROLE = 'guest'

  has_and_belongs_to_many :users
end
