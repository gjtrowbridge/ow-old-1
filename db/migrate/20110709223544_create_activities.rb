class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
		t.string "name", :limit => 100, :null => false
		t.string "organization", :limit => 255, :default => ''
		t.string "description", :limit => 255
		t.timestamps
    end
    add_index :activities, [:name, :organization], :unique => true
  end

  def self.down
    drop_table :activities
  end
end
