class AlterActivities < ActiveRecord::Migration
  	def self.up
		add_column :activities, :user_id, :integer, :null => false
		add_index :activities, :user_id
  	end
	
	
  	def self.down
  		remove_index :activities, :user_id
  		remove_column :activities, :user_id
  	end
end
