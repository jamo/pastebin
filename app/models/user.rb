require 'digest/sha2'
class User < ActiveRecord::Base
  # attr_accessible :title, :body
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$/i
  attr_accessible :first_name, :last_name, :username, :email, :email_confirmation, :password, :password_confirmation
  validates :first_name, :length => { :minimum => 2 }
  validates :last_name, :length => { :minimum => 2 }
  validates :username, :uniqueness => true, :length => { :minimum => 2 }
  validates :email, :confirmation => true, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  validates :email_confirmation, :presence => true
  validates :password, :confirmation => true, :length => { :in => 5..40 }
  validates :password_confirmation, :presence => true

  validates :password, :confirmation => true
  attr_accessor :password_confirmation
  attr_reader   :password

  validate  :password_must_be_present
  
  def User.authenticate(name, password)
   # debugger
    user = User.find_by_username(name)
    if user
      if user.encrypted_password == encrypt_password(password, user.salt)
        user
      end
    end
  end

  def User.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "wibble" + salt)
  end
  
  # 'password' is a virtual attribute
  def password=(password)
    @password = password

    if password.present?
      generate_salt
      self.encrypted_password = self.class.encrypt_password(password, salt)
    end
  end
  
  private

    def password_must_be_present
      errors.add(:password, "Missing password") unless encrypted_password.present?
    end
  
    def generate_salt
      self.salt = self.object_id.to_s + rand.to_s
    end


end
