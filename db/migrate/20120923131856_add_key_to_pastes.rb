class AddKeyToPastes < ActiveRecord::Migration
  def change
    change_table :pastes do |t|
          t.string :key
          add_index :pastes, :key
        end
  end
end
