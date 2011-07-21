class AddActivityFields < ActiveRecord::Migration
  def self.up
  	add_column :activities, :how_to_sign_up, :text
  end

  def self.down
  	remove_column :activities, :how_to_sign_up
  end
end
