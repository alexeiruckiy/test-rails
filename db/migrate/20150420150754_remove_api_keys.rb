class RemoveApiKeys < ActiveRecord::Migration
  def up
    drop_table :api_keys
  end
  def down
    create_table :api_keys do |t|
      t.string :token
      t.references :user, index: true
      t.timestamps
    end
  end
end
