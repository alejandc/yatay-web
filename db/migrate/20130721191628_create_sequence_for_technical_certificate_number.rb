class CreateSequenceForTechnicalCertificateNumber < ActiveRecord::Migration
  def up
    execute 'CREATE SEQUENCE technical_certificate_no START 1;'
  end
end
