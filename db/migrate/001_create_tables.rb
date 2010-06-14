class CreateTables < ActiveRecord::Migration
  def self.up
  	create_table :users do |t|
	  t.integer :id
      t.string :email
      t.date :dob
      t.string :ip
      t.string :opt_in
	  t.integer :height_cm
	  t.integer :weight_lb
	  t.datetime :date
	  t.string :password
	  t.string :firstname
	  t.string :sex
    end
	
    create_table :weights do |t|
	  t.integer :id
      t.integer :weight_lb
      t.string :email
      t.datetime :date
    end
  end

  def self.down
    drop_table :users
    drop_table :weights
  end
end
