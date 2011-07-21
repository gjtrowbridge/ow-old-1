class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
		t.string :address, :null => false
		t.string :city, :null => false
		t.text :note
		t.references :activity
      	t.timestamps
    end
    add_index :locations, :activity_id
  end

  def self.down
    drop_table :locations
  end
end
