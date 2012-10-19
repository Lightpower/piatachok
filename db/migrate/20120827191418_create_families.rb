class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string :name,     null: false
      t.integer :head_id

      t.timestamps
    end

    add_index :families, :name
    add_index :families, :head_id
  end
end
