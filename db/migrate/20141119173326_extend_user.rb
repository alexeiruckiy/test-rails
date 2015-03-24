class ExtendUser < ActiveRecord::Migration
  def change
    rename_column :users, :password_digest, :encrypted_password
    change_column_default :users, :encrypted_password, ''
    change_column_null :users, :encrypted_password, false

    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime

    add_index :users, :email, unique: true
    add_index :users, :confirmation_token, unique: true

  end
end
