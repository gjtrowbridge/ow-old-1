class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
		t.string "name", :limit => 100, :null => false
		t.string "organization", :limit => 255, :default => ''
		t.text "description", :null => false
		t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
