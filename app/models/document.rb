class Document < ActiveRecord::Base
  belongs_to :user
  has_many :pages
  after_create do
    Page.create! document: self
  end

end
