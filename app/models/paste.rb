class Paste < ActiveRecord::Base
  attr_accessible :body, :filename, :nick
  validates :body, :presence => true
  validates :title, :length => { :in => 3..20 }
end
