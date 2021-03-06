class User < ActiveRecord::Base
  
  has_many :favorite_movies
  has_many :favorites, through: :favorite_movies, source: :movie
  has_many :movies
  has_many :reviews, dependent: :destroy
  
	attr_accessor :remember_token
	before_save { self.email = email.downcase }
	validates :name, presence: true, length: { maximum: 25 }
	validates :email, presence: true, length: { maximum: 255 }
	validates :name, :email, uniqueness: true
	
	has_secure_password
	validates :password, confirmation: true, presence: true
	validates :password_confirmation, confirmation: true, presence: true

	  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token
  def User.new_token
  	SecureRandom.urlsafe_base64
  end

  # Remembers a user in the db for use in persistent sessions
   def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest
    def authenticated?(remember_token)
    	return false if remember_digest.nil?
    	BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end   

  #  Forgets a user
  def forget
  	update_attribute(:remember_digest, nil)
  end

  # Displays user name in forum posts
  def forem_name
    name
  end

  
end
