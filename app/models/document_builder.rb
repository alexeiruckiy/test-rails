class DocumentBuilder
  attr_accessor :document

  def initialize(document)
    self.document = document
  end

  def create_blank!
    document.class.transaction do
      document.save!
      document.pages.create!(number: document.pages_count + 1)
    end
    document
  end

end