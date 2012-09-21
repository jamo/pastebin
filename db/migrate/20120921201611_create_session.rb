class CreateSession < ActiveRecord::Migration
  def up
    create_table :sessions do |t|
       t.string :home
        t.string :login
        t.string :logout
        t.string :profile
        t.string :settings

        t.timestamps
      end
  end

  def down
    drop_table :sessions
  end
end
