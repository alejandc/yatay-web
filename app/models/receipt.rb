# == Schema Information
#
# Table name: receipts
#
#  id                    :integer          not null, primary key
#  name                  :string(255)
#  identification_kind   :string(255)
#  identification_number :integer
#  address               :string(255)
#  taxi_license_number   :integer
#  car_brand             :string(255)
#  clock_brand           :string(255)
#  car_model             :integer
#  domain_number         :string(255)
#  clock_number          :string(255)
#  precinct_number       :string(255)
#  motor_number          :string(255)
#  chasis_number         :string(255)
#  observations          :text
#  pulses_per_km         :integer
#  created_at            :datetime
#  updated_at            :datetime
#

class Receipt < ActiveRecord::Base


	
end
