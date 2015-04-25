class ExtendUser < ActiveRecord::Migration
  def change
    rename_column :users, :password_digest, :encrypted_password
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime


    add_index :users, :email, unique: true
    add_index :users, :confirmation_token, unique: true

    reversible do |dir|
      dir.up do
        change_column_default :users, :encrypted_password, ''
        change_column_null :users, :encrypted_password, false
      end
      dir.down do
        change_column_null :users, :encrypted_password, true
        change_column_default :users, :encrypted_password, nil

      end
    end

  end
end
