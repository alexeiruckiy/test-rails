class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.string :description
      t.belongs_to :user, index: true
      t.integer :pages_count
      t.timestamps
    end
  end
end
