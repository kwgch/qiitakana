class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  # Set a filter that is invoked on every request
  before_filter :_set_current_session
  
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :provider, :uid) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me, :provider, :uid) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :provider, :uid) }
  end
      
  def _set_current_session
    accessor = instance_variable_get(:@_request)
    ActiveRecord::Base.send(:define_method, "session", proc {accessor.session})
  end
end
