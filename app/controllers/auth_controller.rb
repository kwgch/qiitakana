# class AuthController < ApplicationController
class AuthController < Devise::OmniauthCallbacksController

  skip_before_filter :authenticate_user!

  def create
    auth = request.env['omniauth.auth']
    uid = auth['uid']
    provider = auth['provider']
    auth = UserAuth.where(uid: uid, provider: provider).first
    if auth
      flash[:notice] = "#{provider}でログインしました。"
      sign_in_and_redirect auth.user, event: :authentication
    else
      authenticate_user!
      user = User.create
      user.user_auth.build(uid: uid, provider: provider, user_id: user.id)
#       UserAuth.create!(uid: uid, provider: provider, user_id: current_user.id)
      redirect_to root_url, notice: "#{provider}と連携しました。"
    end
  end

  def destroy
    provider = params.require(:provider)
    authenticate_user!
    auth = UserAuth.where(provider: provider, user_id: current_user.id).first
    auth.destroy if auth
    redirect_to root_url, notice: "#{provider}と連携解除しました。"
  end

  def github
    oauth_post_process(:github)
  end

  def twitter
    oauth_post_process(:twitter)
  end
  
  private
  def user_params
    request.env["omniauth.auth"].slice(:provider, :uid, :email).to_h
  end
  
  def oauth_post_process(provider)
#     user_params['email'] = "#{user_params['uid']}@#{user_params['provider']}"
#     user_params_clone = user_params.dup
#     user_params_clone.store(:email, "#{user_params['uid']}@#{user_params['provider']}")
   
    auth = request.env['omniauth.auth']
    uid = auth['uid']
#     provider = auth['provider']
    auth = UserAuth.where(uid: uid, provider: provider).first
    
#     unless auth
#       user = User.create
#       auth = user.user_auth.build(uid: uid, provider: provider, user_id: user.id)
# #       auth = UserAuth.find_or_create_by(user_params)
#     end
   
    if auth.try(:persisted?)
      sign_in_and_redirect auth.user, event: :authentication
      set_flash_message(:notice, :success, kind: provider.to_s.capitalize) if is_navigational_format?
    else
      session[:current_provider_date] = request.env["omniauth.auth"].except('extra')
#       session["devise.#{provider.to_s}_data"] = request.env["omniauth.auth"].except('extra')
      redirect_to new_user_registration_url
    end
    
  end

end