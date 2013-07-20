class CertificatesController < ApplicationController
  
  def index
    @certificates = Certificate.order("created_at DESC").page(params[:page])
  end
end
