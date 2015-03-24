class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :name

      t.timestamps
    end
    add_reference :user, :entity, index: true
  end
end
