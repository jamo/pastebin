class AddFilesizeToPastes < ActiveRecord::Migration
  def up
    add_column :pastes, :size, :string, :default => "0 bytes"  
  end

  def down
    remove_column :pastes, :size
  end
end