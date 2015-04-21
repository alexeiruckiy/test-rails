class DocumentBuilder
  attr_accessor :document

  def initialize(document)
    self.document = document
  end

  def create_blank!
    ActiveRecord::Base.transaction do
      document.save!
      Page.create!(document: document)
    end
    document
  end

end