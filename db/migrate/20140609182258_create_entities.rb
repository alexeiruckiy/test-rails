class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :name

      t.timestamps
    end
    add_reference :users, :entity, index: true
  end
end
