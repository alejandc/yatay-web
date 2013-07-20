class CertificatesController < ApplicationController
  
  def index
    @certificates = Certificate.order("created_at DESC").page(params[:page])
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
end
