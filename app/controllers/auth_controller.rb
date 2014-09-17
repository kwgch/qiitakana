class AuthController < Devise::OmniauthCallbacksController

  skip_before_filter :authenticate_user!

#   def create
#     auth = request.env['omniauth.auth']
#     uid = auth['uid']
#     provider = auth['provider']
#     auth = UserAuth.where(uid: uid, provider: provider).first
#     if auth
#       flash[:notice] = "#{provider}でログインしました。"
#       sign_in_and_redirect auth.user, event: :authentication
#     else
#       authenticate_user!
#       current_user.user_auth.build(uid: uid, provider: provider, user_id: user.id)
#       redirect_to root_url, notice: "#{provider}と連携しました。"
#     end
#   end

  def destroy
    provider = params.require(:provider)
    authenticate_user!
    auth = UserAuth.where(provider: provider, user_id: current_user.id).first
    auth.destroy if auth
    redirect_to edit_user_registration_path, notice: "#{provider}と連携解除しました。"
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
    auth = request.env['omniauth.auth']
    uid = auth['uid']
    auth = UserAuth.where(uid: uid, provider: provider).first
#     binding.pry
    if auth.try(:persisted?)
      if current_user && current_user.id != auth.user_id
        redirect_to edit_user_registration_path, alert: "既に他のアカウントに紐付けられています。"         
      else  
        sign_in_and_redirect auth.user, event: :authentication
        # ログインしました。
        set_flash_message(:notice, :success, kind: provider.to_s.capitalize) if is_navigational_format?
      end
    else
      session[:current_provider_date] = request.env["omniauth.auth"].except('extra')
      if current_user
        current_user.user_auth.build(uid: uid, provider: provider, user_id: current_user.id).save
        redirect_to edit_user_registration_path, notice: "#{provider}と連携しました。"
      else
        redirect_to new_user_registration_url #新規登録
      end
    end
  end
end