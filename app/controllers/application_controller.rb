class ApplicationController < ActionController::Base
  include SessionHelper
  
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_session
  before_action :set_operator

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