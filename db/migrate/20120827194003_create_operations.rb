class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.string :type
      t.integer :amount
      t.integer :category_id
      t.integer :user_id
      t.integer :created_by,    null: false
      t.text :comment
      t.integer :family_id,     null: false

      t.timestamps
    end

    add_index :operations, :type
    add_index :operations, :category_id
    add_index :operations, :user_id
    add_index :operations, :created_by
  end
end
