class Paste < ActiveRecord::Base
  attr_accessible :body, :filename, :nick, :title
  validates :body, :presence => true
  validates :title, :length => { :minimum => 3 }
end
