module LinkHelper

  def login_text(provider)
    fa_icon provider, text: "#{ provider.capitalize }で新規登録／ログイン"
  end

  def signin_link_of(provider)
    link_to login_text(provider.to_s), user_omniauth_authorize_path(provider), class: "btn btn-default"
  end

  def signout_link
    link_to fa_icon('sign-out', text: 'ログアウト'), destroy_user_session_path, method: 'delete'
  end

  def account_config_link
    link_to fa_icon('cog', text: 'アカウント設定'), '/users/edit'
  end

  def profile_config_link
    link_to fa_icon('user', text: 'プロフィール設定'), 
      (current_user.profile.present? && current_user.profile.id.present? ?
        edit_user_profile_path(current_user, current_user.profile) :
        new_user_profile_path(current_user))
  end
  
#   def link_to_sign_in_or_out(html_options={})
#     if user_signed_in?
#       body = icon(:'sign-out') + t(:"devise.shared.links.sign_out", default: "Sign out")
#       html_options = { method: :delete }.merge(html_options)
#       link_to body, :destroy_user_session, html_options
#     else
#       body = icon(:'sign-in') + t(:"devise.shared.links.sign_in", default: "Sign in")
#       link_to body, :new_user_session, html_options
#     end
#   end
  
  def link_to_provider(provider, html_options={})
    txt,path = '',''
    if UserAuth.registered? current_user, provider
      html_options = { class: 'btn btn-default' }.merge(html_options)
      html_options = { method: :delete }.merge(html_options)
      path = destroy_connection_path(provider)
      txt = "#{ provider.capitalize }の紐付けを解除"
#       link_to fa_icon(provider, text: "#{ provider.capitalize }の紐付けを解除"), destroy_connection_path(provider), html_options
    else
      html_options = { class: 'btn btn-info' }.merge(html_options)
      path = user_omniauth_authorize_path(provider)
      txt = "#{ provider.capitalize }と連携"
#       link_to fa_icon(provider, text: "#{ provider.capitalize }と連携"), user_omniauth_authorize_path(provider), html_options
    end
    link_to fa_icon(provider, text: txt), path, html_options
  end
end