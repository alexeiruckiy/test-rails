class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name, null: false
      t.string :description
      t.references :user, index: true
      t.integer :pages_count
      t.timestamps
    end
  end
end
