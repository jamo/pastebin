class Paste < ActiveRecord::Base
  attr_accessible :body, :filename, :nick, :title, :encoding
  validates :body, :presence => true
  validates :key, :uniqueness => true
  LANG = {:Java => 'java',:Nome => 'text',:Ruby => 'ruby', :HTML => 'html', :'C++' => 'cpp',
    :js => 'java_script', 'erb' => 'erb','rhtml' => 'erb'}
=begin
  avail = :'c++'       => :cpp,
      :cplusplus   => :cpp,
      :ecmascript  => :java_script,
      :ecma_script => :java_script,
      :rhtml       => :erb,
      :eruby       => :erb,
      :irb         => :ruby,
      :javascript  => :java_script,
      :js          => :java_script,
      :pascal      => :delphi,
      :patch       => :diff,
      :plain       => :text,
      :plaintext   => :text,
      :xhtml       => :html,
      :yml         =>:text
=end  
  before_create :generate_key
  
  def generate_key 
    self.key = Digest::SHA1.hexdigest(Time.now.to_s+Random.rand.to_s+self.body).slice(0..7)
  end
  
end
