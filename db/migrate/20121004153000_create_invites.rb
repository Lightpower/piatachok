class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :family_id,           null: false
      t.integer :user_id
      t.string :email
      t.boolean :is_sent_to_email,    null:false, default: false
      t.integer :created_by,          null: false

      t.timestamps
    end

    add_index :invites, :family_id
    add_index :invites, :user_id
    add_index :invites, :created_by
    add_index :invites, [:family_id, :user_id], unique: true
  end
end
