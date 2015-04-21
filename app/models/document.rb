class Document < ActiveRecord::Base
  include EntityBinding

  belongs_to :user
  has_many :pages

end
