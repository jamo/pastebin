class Paste < ActiveRecord::Base
  attr_accessible :body, :filename, :nick, :title, :encoding
  validates :body, :presence => true
  validates :key, :uniqueness => true
  LANG = ['java','text','java_script','ruby','html']
  
  before_create :generate_key
  
  def generate_key 
    self.key = Digest::SHA1.hexdigest(Time.now.to_s+Random.rand.to_s+self.body).slice(0..7)
  end
  
end
