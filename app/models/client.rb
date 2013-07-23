# encoding: utf-8

# == Schema Information
#
# Table name: clients
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  document_type   :string(255)
#  document_number :string(255)
#  address         :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class Client < ActiveRecord::Base
  
  DOCUMENT_TYPES = ["DNI", "CI", "LE", "LC"]

	has_many :certificates, :dependent => :destroy
	
	accepts_nested_attributes_for :certificates

  validates :document_number, numericality: { only_integer: true }
  validates :document_type, inclusion: { in: Client::DOCUMENT_TYPES }
  validates :name, :document_type, :document_number, :address, length: { maximum: 250 }, 
            format: { with: /\A[a-zA-Z\d\s\._-]+\z/, message: "Solo se puede ingresar letras, numeros y los simbolos: - _ ." }
  validates :name, :document_type, :document_number, :address, :presence => true
  
  
  def get_document_info
    "#{self.document_type} #{self.document_number}"
  end
  
  
  def self.search(client_filter)
    query = {}
    
    joins_info = ""
    if !client_filter.certificates.first.nil? and !client_filter.certificates.first.taxi_license_number.blank?
      query['certificates.taxi_license_number'] = client_filter.certificates.first.taxi_license_number.strip
      joins_info = "JOIN certificates ON certificates.client_id = clients.id"
    end
    
    unless client_filter.name.blank?
      query['name'] = client_filter.name.strip
    end
    
    unless client_filter.document_number.blank?
      query['document_number'] = client_filter.document_number.strip
    end
    
    unless joins_info.blank?
      joins(joins_info).where(query)
    else
      where(query)
    end
  end
end
