class AddEncodingToPaste < ActiveRecord::Migration
  def change
    change_table :pastes do |t|
          t.string :encoding, :default => "java"
    end
  end
end
