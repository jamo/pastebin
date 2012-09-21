class AddTitleToPastes < ActiveRecord::Migration
  def change
    change_table :pastes do |t|
          t.string :title, :null => "<ei otsikkoa>"
        end
  end
end
