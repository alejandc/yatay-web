class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.where("id != ?", current_user.id).order(:username)
  end
  
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    @user = User.find(params[:id])

    if params[:role]
      Role::ROLES.each do |role|
        @user.remove_role role.to_sym
      end
      
      params[:role].each do |role|
        @user.add_role role.to_sym
      end
    end

    if @user.update_attributes(user_params)
      redirect_to admin_users_path, :notice => "El usuario #{@user.username} fue actualizado correctamente."
    else
      respond_to do |format|
        format.html  { render :edit }
        format.js { render :edit }
      end
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      if params[:role]    
          #al ser una coleccion recorre cada uno de los roles y se los asigna al usuario        
          params[:role].each { |role| @user.add_role role.to_sym  } 
      end
      
      redirect_to admin_users_path, :notice => 'El usuario fue creado correctamente.'
    else
      respond_to do |format|
        format.html { render :new }
        format.js { render :new }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to admin_users_path, :notice => "El usuario ha sido eliminado."
  end
  
  private
    def user_params
      params_user = ActionController::Parameters.new(params['user'])
      params_user.permit!
      params_user
    end
end
