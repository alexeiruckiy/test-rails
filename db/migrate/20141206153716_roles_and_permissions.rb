class RolesAndPermissions < ActiveRecord::Migration
  def change

    create_table :roles do |t|
      t.string :name
      t.timestamps
    end

    create_join_table :roles, :users do |t|
      t.index [:role_id, :user_id]
    end

  end
end
