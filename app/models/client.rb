# == Schema Information
#
# Table name: clients
#
#  id              :integer          not null, primary key
#  titular         :string(255)
#  document_type   :string(255)
#  document_number :string(255)
#  address         :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class Client < ActiveRecord::Base

	has_many :certificates, :dependent => :destroy

	

	

end
