class ClientsController < ApplicationController

  def index
    respond_to do |format|
      format.html do
        @client_filter = Client.new
        
        if params[:client]
          @client_filter.attributes = params[:client]
          @clients = Client.search(@client_filter).order("created_at DESC").page(params[:page])
        else
          @client_filter.certificates = [Certificate.new]
          @clients = Client.order("created_at DESC").page(params[:page])
        end
      end
    end
  end

  def new
    @client = Client.new
  end
  
  def edit
    @client = Client.find(params[:id])
  end

  def create
    @client = Client.new(client_params)
    
    if @client.save
      redirect_to clients_path, :notice => I18n.t('notice_client_created_successfully')
    else
      respond_to do |format|
        format.html { render :new }
      end
    end
  end

  def show
    @client_filter = Client.new
    @client = Client.find(params[:id])
    
    respond_to do |format|
      format.html
    end
  end
  
  def update
    @client = Client.find(params[:id])

		if @client.update_attributes(client_params)
			redirect_to clients_path
		else
			respond_to do |format|
        format.html { render :edit }
      end
		end
  end
  
  #def destroy
	#	@client = Client.find(params[:id])
#		@client.destroy
	#	
	#	respond_to do |format|
	#	  format.html { redirect_to clients_url }
	#    format.js
	#  end
	#end

  private
    def client_params
      params_client = ActionController::Parameters.new(params[:client])
      params_client.permit!
      params_client
    end

end
