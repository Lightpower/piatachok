class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :first_name
      t.string :last_name
      t.integer :family_id

      t.timestamps
    end

    add_index :users, :family_id
  end
end
