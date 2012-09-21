class Paste < ActiveRecord::Base
  attr_accessible :body, :filename, :nick
  validates :body, :presence => true
end
