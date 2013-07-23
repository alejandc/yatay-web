class CertificatesController < ApplicationController
  
  def index
    respond_to do |format|
      format.html do
        @certificate = Certificate.new
        @certificate.client = Client.new
        
        if params[:certificate]
          @certificate.attributes = params[:certificate]
          @certificate.client.attributes = params[:certificate][:client]
          
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
  
  def edit
    @certificate = Certificate.find(params[:id])
  end
  
  def create
    @certificate = Certificate.new(certificate_params)
    
    if @certificate.save
      redirect_to certificates_path, :notice => I18n.t('notice_certificate_created_successfully')
    else
      respond_to do |format|
        format.html { render :new }
      end
    end
  end
  
  def show
    @certificate = Certificate.find(params[:id])
    
    respond_to do |format|
      format.html
      format.pdf do
        pdf = CertificatePdf.new(@certificate)
        send_data pdf.render, filename: "certificado_tecnico_#{@certificate.client.name.gsub(/\s+/, '_')}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

  def edit
    @certificate = Certificate.find(params[:id])
  end
  
  def update
    @certificate = Certificate.find(params[:id])

		if @certificate.update_attributes(certificate_params)
			redirect_to certificates_path
		else
			respond_to do |format|
        format.html { render :edit }
      end
		end
  end
  
  private
    def certificate_params
      params_certificate = ActionController::Parameters.new(params['certificate'])
      params_certificate.permit!
      params_certificate
    end
  
end
