class ClientsController < ApplicationController

  def index
    respond_to do |format|
      format.html do
        @client = Client.new
        
        if params[:client]
          @client.attributes = params[:client]
          @client = Client.search(@certificate).order("created_at DESC").page(params[:page])
        else
          @client = Client.order("created_at DESC").page(params[:page])
        end
      end
    end
  end

  def new
    @client = Client.new
  end

  def create
    debugger
    @client = Client.create(params[:client])
    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'El cliente fue cargado' }
        format.json { render json: @client, status: :created, location: @client}
      else
        format.html { render action: "new" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @client_filter = Client.new
    @client = Client.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end  

  private
    def client_params
      params_client = ActionController::Parameters.new(params[:client])
      params_client.permit!
      params_client
    end

end
