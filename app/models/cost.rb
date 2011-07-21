class Cost < ActiveRecord::Base

	#Validations
	validates :dollar_amount, :presence => true, :numericality =>  {:greater_than_or_equal_to => 0}
	validates :unit_number, :presence => true, :numericality => { :greater_than => 0 }
	validates :unit_name, :presence => true, :length => { :within => 1..30 }
	
	#Associations
	belongs_to :activity

	#Protects from mass assignment
	attr_protected :user_id
	
	#Callbacks
	after_initialize :reformat_unit_number
	
	private
	
	def reformat_unit_number
		self.unit_number = self.unit_number.to_i
	end

end
