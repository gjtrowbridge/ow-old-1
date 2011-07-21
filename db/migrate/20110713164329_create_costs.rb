class CreateCosts < ActiveRecord::Migration
  def self.up
    create_table :costs do |t|
		t.float :dollar_amount, :null => false
		t.float :unit_number, :default => 1, :null => false 
		t.string :unit_name, :null => false, :default => 'day'
		t.references :activity
    	t.timestamps
    end
    add_index :costs, :activity_id
  end

  def self.down
    drop_table :costs
  end
end
