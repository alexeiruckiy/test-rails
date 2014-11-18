class Page < ActiveRecord::Base
  has_one :user, through: :document
  belongs_to :document, counter_cache: true

  scope :belong_document, ->(document) { where(document_id: document) }

  after_create :past_to_end
  after_update :check_pages_number

  def past_to_end
    connection = ActiveRecord::Base.connection.raw_connection
    stm = connection.prepare "UPDATE #{Page.table_name} SET number = (SELECT pages_count FROM #{Document.table_name} WHERE id = :document_id) WHERE id = :id"
    stm.execute document_id: document_id, id: id
  end

  def check_pages_number
    #connection = ActiveRecord::Base.connection.raw_connection
    #stm = connection.prepare "UPDATE #{Page.table_name} SET number = (SELECT COUNT(*) FROM #{Page.table_name} WHERE number <= :number AND document_id = :document_id) WHERE id <> :id AND number >= :number"
    #stm.execute document_id: document_id, id: id
  end
end
