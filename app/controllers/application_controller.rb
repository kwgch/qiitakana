class ApplicationController < ActionController::Base
  include SessionHelper

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_session
  before_action :set_operator

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :provider, :uid) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me, :provider, :uid) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :provider, :uid) }
  end

  private

    # model から sessionを参照可能にする
    def set_current_session
      accessor = instance_variable_get(:@_request)
      ActiveRecord::Base.send(:define_method, "session", proc { accessor.session })
    end

    def set_operator
      RecordWithOperator.operator = current_user
    end

end
