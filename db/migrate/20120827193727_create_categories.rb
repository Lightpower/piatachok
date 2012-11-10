class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string  :name
      t.integer :family_id
      t.string  :type
    end

    add_index :categories, :name
    add_index :categories, :type
    add_index :categories, :family_id
  end
end
