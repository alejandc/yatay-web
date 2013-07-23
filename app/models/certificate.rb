# encoding: utf-8

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
#  client_id                    :integer
#  created_at                   :datetime
#  updated_at                   :datetime
#

class Certificate < ActiveRecord::Base
  paginates_per 20
  after_initialize :preset_values
  before_save :set_technical_certificate_number

  belongs_to :client

  accepts_nested_attributes_for :client
  
  
  validates :technical_certificate_number, :car_model, :pulses_per_km, numericality: { only_integer: true }
  
  validates :registrant, :business_address, :gross_income_number, :habilitation, :cuit, 
            :legal_metrology_number, :technical_certificate_number, :registration_ssty_number,
            :taxi_license_number, :car_brand, :clock_brand, :car_model, :domain_number, :clock_number,
            :precinct_number, :motor_number, :chasis_number, :observations, :pulses_per_km, length: { maximum: 250 }
            
  validates :registrant, :business_address, :gross_income_number, :habilitation, :cuit, 
            :legal_metrology_number, :technical_certificate_number, :registration_ssty_number,
            :taxi_license_number, :car_brand, :clock_brand, :car_model, :domain_number, :clock_number,
            :precinct_number, :motor_number, :chasis_number, :observations, :pulses_per_km, 
            format: { with: /\A[a-zA-Z\d\s\._-]+\z/ , message: "Solo se puede ingresar letras, numeros y los simbolos: - _ ."}
            
  validates :registrant, :business_address, :gross_income_number, :habilitation, :cuit, 
            :legal_metrology_number, :technical_certificate_number, :registration_ssty_number,
            :taxi_license_number, :car_brand, :clock_brand, :car_model, :domain_number, :clock_number,
            :precinct_number, :motor_number, :chasis_number, :observations, :pulses_per_km, :client_id, :presence => true
  
  def preset_values
    if self.new_record?
      self.registrant                   = "RELOJERIA YATAY"
      self.business_address             = "Yatay 278"
      self.gross_income_number          = "1256878-3"
      self.habilitation                 = "2004497-2012"
      self.cuit                         = "20-11554805-1"
      self.legal_metrology_number       = "7595"
      self.registration_ssty_number     = "036"
    end
  end
  
  # Autoincrementamos el numero del certificado tecnico
  def set_technical_certificate_number
    if self.technical_certificate_number.nil?
      self.technical_certificate_number = ActiveRecord::Base.connection.select_value("select nextval('technical_certificate_no')")
    end
  end
  
  # Metodo para aplicar el filtro seteado por el usuario
  def self.search(certificate_filter)
    query = {}
    
    joins_info = ""
    if !certificate_filter.client.nil? and !certificate_filter.client.name.blank?
      query['clients.name'] = certificate_filter.client.name.strip
      joins_info = "JOIN clients ON certificates.client_id = clients.id"
    end
    
    unless certificate_filter.taxi_license_number.blank?
      query['taxi_license_number'] = certificate_filter.taxi_license_number.strip
    end
    
    unless certificate_filter.clock_number.blank?
      query['clock_number'] = certificate_filter.clock_number.strip
    end
    
    unless joins_info.blank?
      joins(joins_info).where(query)
    else
      where(query)
    end
  end
  
end
