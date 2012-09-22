class Paste < ActiveRecord::Base
  attr_accessible :body, :filename, :nick, :title, :encoding
  validates :body, :presence => true
  validates :title, :length => { :minimum => 3 }
  
   LANG = ['java','text','java_script','ruby','html']
end
