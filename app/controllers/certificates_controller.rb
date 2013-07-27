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
    if params[:certificate_id]
      @certificate = Certificate.find(params[:certificate_id]).dup
      @certificate_id_refered = params[:certificate_id]
    else
      @certificate = Certificate.new
    end
    
    @client_id = params[:client_id]
  end
  
  def edit
    @certificate = Certificate.find(params[:id])
  end
  
  def create
    @certificate = Certificate.new(certificate_params)
    
    if @certificate.save
      # Borramos el certificado que estamos renovando ya que fue duplicado...
      unless params[:certificate_id_refered].blank?
        Certificate.find(params[:certificate_id_refered]).destroy
      end
      redirect_to certificate_path(@certificate)
    else
      @client_id = params[:client_id]
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
  
  def destroy
  	@certificate = Certificate.find(params[:id])
  	@certificate.destroy
  	
  	respond_to do |format|
  	  format.html { redirect_to certificates_url }
      format.js
    end
  end
  
  private
    def certificate_params
      params_certificate = ActionController::Parameters.new(params['certificate'])
      params_certificate.permit!
      params_certificate
    end
  
end
