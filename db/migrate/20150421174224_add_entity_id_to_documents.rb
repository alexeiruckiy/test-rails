class AddEntityIdToDocuments < ActiveRecord::Migration
  def change
    add_reference :documents, :entity, index: true
  end
end
