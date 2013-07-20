class CreateCertificates < ActiveRecord::Migration
  def change
    create_table :certificates do |t|
      t.string  :registrant
      t.string  :business_address
      t.string  :gross_income_number
      t.string  :habilitation
      t.string  :cuit
      t.string  :legal_metrology_number
      t.integer :technical_certificate_number
      t.integer :registration_ssty_number
      
      t.string  :titular
	    t.string  :document_type
	    t.integer :document_number
  		t.string  :address
  		t.integer :taxi_license_number   
  		t.string  :car_brand
  		t.string  :clock_brand
  		t.integer :car_model
  		t.string  :domain_number
  		t.string  :clock_number
  		t.string  :precinct_number
  		t.string  :motor_number
  		t.string  :chasis_number
  		t.text    :observations
  		t.integer :pulses_per_km

      t.timestamps
    end
    
    add_index :certificates, :titular
    add_index :certificates, :document_number
    add_index :certificates, :clock_brand
    add_index :certificates, :taxi_license_number
    add_index :certificates, :clock_number
    add_index :certificates, :precinct_number
    add_index :certificates, :motor_number
    add_index :certificates, :chasis_number
    add_index :certificates, :domain_number
  end
end
