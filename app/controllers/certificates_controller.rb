class CertificatesController < ApplicationController
  
  def index
    respond_to do |format|
      format.html do
        @certificate = Certificate.new
        
        if params[:certificate]
          @certificate.attributes = params[:certificate]
          @certificates = Certificate.search(@certificate).order("created_at DESC").page(params[:page])
        else
          @certificates = Certificate.order("created_at DESC").page(params[:page])
        end
      end
    end
  end
  
  def new
    @certificate = Certificate.new
  end
  
  def create
    
  end
  
  def show
    
  end
  
  def edit
    @certificate = Certificate.find(params[:id])
  end
  
  def update
    
  end
  
  private
    def certificate_params
      params_certificate = ActionController::Parameters.new(params['certificate'])
      params_certificate.permit!
      params_certificate
    end
  
end
