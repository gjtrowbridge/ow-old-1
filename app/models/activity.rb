class Activity < ActiveRecord::Base
	
	#Validations
	validates :name, :length => {:within => 4..50 }, :presence => true
	validates :organization, :presence => true, :length => { :maximum => 255 }
	validates_uniqueness_of :name, :scope => :organization
	
	validates :description, :presence => true
	validates :how_to_sign_up, :presence => true
	
	#Protects these from mass assignment
	attr_protected :user_id
	
	#Defines associations
	belongs_to :user
	has_many :costs
	has_many :locations
	
	
end
