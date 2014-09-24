module PostsHelper
  def date_format(post)
    post.created_at.strftime("%Y/%m/%d")
  end
  
  def user_link(post)
    link_to(post.user.username, user_posts_path(post.user)) + "が#{ date_format post }に投稿"
  end
  
  def post_link(post)
    link_to post.title, [post.user, post]
  end
  
  def tags_link(post)
    return unless post.tags.length
    post.tags.map(&:name).map { |t| content_tag "li", link_to(t, tag_path(t)) }.join(' ').html_safe
  end
end
