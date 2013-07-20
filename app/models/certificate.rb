# == Schema Information
#
# Table name: certificates
#
#  id                           :integer          not null, primary key
#  registrant                   :string(255)
#  business_address             :string(255)
#  gross_income_number          :string(255)
#  habilitation                 :string(255)
#  cuit                         :string(255)
#  legal_metrology_number       :string(255)
#  technical_certificate_number :integer
#  registration_ssty_number     :integer
#  titular                      :string(255)
#  document_type                :string(255)
#  document_number              :integer
#  address                      :string(255)
#  taxi_license_number          :integer
#  car_brand                    :string(255)
#  clock_brand                  :string(255)
#  car_model                    :integer
#  domain_number                :string(255)
#  clock_number                 :string(255)
#  precinct_number              :string(255)
#  motor_number                 :string(255)
#  chasis_number                :string(255)
#  observations                 :text
#  pulses_per_km                :integer
#  created_at                   :datetime
#  updated_at                   :datetime
#

class Certificate < ActiveRecord::Base
end
