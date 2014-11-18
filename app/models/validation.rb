class Validation < ActiveRecord::Base
  belongs_to :entity, dependent: :destroy
end
