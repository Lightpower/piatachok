class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :type
    end

    add_index :categories, :name
    add_index :categories, :type
  end
end
