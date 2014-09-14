module LinkToAuthHelper
  
  def login_text(provider)
    fa_icon provider, text: "#{ provider.capitalize }で新規登録／ログイン"
  end
  
  def signin_link_of(provider)
    link_to (login_text provider.to_s), user_omniauth_authorize_path(provider), class: "btn btn-default"
  end
  
  def signout_link
    link_to (fa_icon 'sign-out', text: 'Sign out', right: true), destroy_user_session_path, method: 'delete'
  end

  
  def link_to_sign_in_or_out(html_options={})
    if user_signed_in?
      body = icon(:'sign-out') + t(:"devise.shared.links.sign_out", default: "Sign out")
      html_options = { method: :delete }.merge(html_options)
      link_to body, :destroy_user_session, html_options
    else
      body = icon(:'sign-in') + t(:"devise.shared.links.sign_in", default: "Sign in")
      link_to body, :new_user_session, html_options
    end
  end
  
  
  def link_to_provider(provider, html_options={})
    if UserAuth.where(user_id: current_user.id, provider: provider).exists?
#       html_options = { method: :delete }.merge(html_options)
      link_to (fa_icon provider, text: "#{ provider.capitalize }の紐付けを解除"), destroy_connection_path(provider), method: 'delete'
    else
      link_to (fa_icon provider, text: "#{ provider.capitalize }と連携"), "/auth/#{ provider }", html_options
    end
  end
end