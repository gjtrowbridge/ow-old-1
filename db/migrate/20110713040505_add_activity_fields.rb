class AddActivityFields < ActiveRecord::Migration
  def self.up
  	add_column :activities, :signup_instructions, :string, :limit => 255
  	add_column :activities, :requirements, :string, :limit => 255
  end

  def self.down
  	remove_column :activities, :signup_instructions
  	remove_column :activities, :requirements
  end
end