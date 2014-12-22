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

  def link_to_provider(provider, html_options={})
    txt,path = '',''
    if UserAuth.registered? current_user, provider
      html_options = { class: 'btn btn-default' }.merge(html_options)
      html_options = { method: :delete }.merge(html_options)
      path = destroy_connection_path(provider)
      txt = "#{ provider.capitalize }の紐付けを解除"
    else
      html_options = { class: 'btn btn-info' }.merge(html_options)
      path = user_omniauth_authorize_path(provider)
      txt = "#{ provider.capitalize }と連携"
    end
    link_to fa_icon(provider, text: txt), path, html_options
  end

  def new_post_link
    link_to '投稿する', new_user_post_path(current_user)
  end

  def drafts_link
    link_to '下書き一覧', drafts_path
  end

end