class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def github
    oauth_post_process('github')
  end

  def twitter
    oauth_post_process('twitter')
  end
  
  private
  def user_params
    request.env["omniauth.auth"].slice(:provider, :uid, :email).to_h
  end
  
  def oauth_post_process(provider)
#     user_params['email'] = "#{user_params['uid']}@#{user_params['provider']}"
    user_params_clone = user_params.dup
    user_params_clone.store(:email, "#{user_params['uid']}@#{user_params['provider']}")
    @user = User.find_or_create_by(user_params_clone)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"].except('extra')
      redirect_to new_user_registration_url
    end
  end
end