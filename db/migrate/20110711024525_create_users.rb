class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
		t.string "username", :limit => 50, :null => false, :unique => true
		t.string "email", :limit => 255, :default => ''
		t.string "hashed_password", :null => false
		t.string "salt"
		t.boolean "is_admin", :default => false
		t.boolean "activated", :default => false
		t.string "activation_key"
      	t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
