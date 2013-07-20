class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  
  # Parche para usar cancan con rails 4 (https://github.com/ryanb/cancan/issues/835)
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
  
  def after_sign_in_path_for(resource)
    certificates_path
  end
end
