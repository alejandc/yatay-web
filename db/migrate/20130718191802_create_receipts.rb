class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
    	t.string :name
	    t.string :identification_kind
	    t.integer :identification_number
  		t.string :address
  		t.integer :taxi_license_number   
  		t.string :car_brand
  		t.string :clock_brand
  		t.integer :car_model
  		t.string :domain_number
  		t.string :clock_number
  		t.string :precinct_number
  		t.string :motor_number
  		t.string :chasis_number
  		t.text :observations
  		t.integer :pulses_per_km

     	t.timestamps
    end
  end
end
