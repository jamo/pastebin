class CreateUser < ActiveRecord::Migration
  def up
    create_table :users, :force => true do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :email
      t.string :encrypted_password
      t.string :salt
      t.boolean :admin, :default => false
      t.boolean :super_admin, :default => false
      t.boolean :disabled, :default => false
      t.datetime :last_login
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
