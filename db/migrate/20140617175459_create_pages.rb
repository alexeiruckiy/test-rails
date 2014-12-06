class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :number
      t.string :content
      t.references :document, index: true
      t.timestamps
    end
  end
end
