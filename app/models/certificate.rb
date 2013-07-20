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
#  registration_ssty_number     :string(255)
#  titular                      :string(255)
#  document_type                :string(255)
#  document_number              :string(255)
#  address                      :string(255)
#  taxi_license_number          :string(255)
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
  paginates_per 20
  after_initialize :preset_values

  def preset_values
    if self.new_record?
      self.registrant                   = "RELOJERIA YATAY"
      self.business_address             = "Yatay 278"
      self.gross_income_number          = "1256878-3"
      self.habilitation                 = "2004497/2012"
      self.cuit                         = "20-11554805-1"
      self.legal_metrology_number       = "7595"
      # Se debe autoincrementar el technical_certificate_number
      #self.technical_certificate_number = 0
      self.registration_ssty_number     = "036"
    end
  end
  
  def self.search(certificate_filter)
    query = {}
    
    unless certificate_filter.titular.blank?
      query['titular'] = certificate_filter.titular
    end
    
    unless certificate_filter.taxi_license_number.blank?
      query['taxi_license_number'] = certificate_filter.taxi_license_number
    end
    
    unless certificate_filter.clock_number.blank?
      query['clock_number'] = certificate_filter.clock_number
    end
    
    where(query)
  end
end
