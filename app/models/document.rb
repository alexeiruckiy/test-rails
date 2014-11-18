class Document < ActiveRecord::Base
  belongs_to :user
  has_many :pages

  def self.create_document(params)
    Document.transaction do
      document = Document.create! params
      Page.create! document: document
      document
    end
  end

end
