class CreateValidations < ActiveRecord::Migration
  def change
    create_table :validations do |t|
      t.string :field
      t.string :rule
      t.string :message
      t.belongs_to :entity, index: true
      t.timestamps
    end
  end
end
