class User < ActiveRecord::Base
	
	#Adds read-write methods for these non-database fields
	attr_accessor :password, :password_confirmation, :email_confirmation
	
	#Validations
	validates :username, :length => {:within => 4..25 }, :uniqueness => true
	validates :email, :presence => true, :length => {:maximum => 100}, :format => EMAIL_REGEX, :confirmation => true, :uniqueness => true
	
	#Makes sure the confirmation fields match
	validates_confirmation_of :password
	
	#Only validates on create
	validates_length_of :password, :within => 6..50, :on => :create
	
	#Prevents mass-assignment from acting on these fields
	attr_protected :hashed_password, :salt, :created_at, :updated_at, :is_admin, :activation
	
	#Defines associations
	has_many :activities
	
	before_save :create_hashed_password
	before_create :store_activation_key
	after_save :clear_password
	
	def self.make_salt(username="")
		Digest::SHA2.hexdigest("Created some seasoning called #{username} at #{Time.now}")
	end
	
	def self.create_activation_key(username="")
		Digest::SHA2.hexdigest("This activation code was created for #{username} by the orange walrus at #{Time.now}.  Booyakashah x #{rand(500)} / #{rand(200)}}")
	end
	
	def self.hash_with_salt(password="", salt="")
		Digest::SHA2.hexdigest("Pour some #{salt} on me...and the #{password}")
	end
	
	def self.authenticate(username="",password="")
		user = find_by_username(username)
		if user && user.password_match?(password)
			return user
		else
			return false
		end
	end
	
	def password_match?(password="")
		self.hashed_password == User.hash_with_salt(password, self.salt)
	end
	
	private
	
	def store_activation_key
		self.activated = false
		self.activation_key = User.create_activation_key(username)
	end
	
	def create_hashed_password
		#Whenever :password has a value hashing is needed
		unless password.blank?
			# always use "self" when assigning values
			self.salt = User.make_salt(username) if salt.blank?
			self.hashed_password = User.hash_with_salt(password, salt)
		end
	end
	
	def clear_password
		#clears password for security purposes after it is no longer needed
		self.password = nil
	end
	
end
