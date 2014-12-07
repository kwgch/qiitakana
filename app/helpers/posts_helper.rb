module PostsHelper
  
  def date_format(post)
    post.created_at.strftime("%Y/%m/%d")
  end
  
  def user_link(post)
    link_to(post.user.username, user_posts_path(post.user)) + "が#{ date_format post }に#{ post.temporary ? '下書き' : '投稿' }"
  end
  
  def post_link(post)
    link_to post.title, [post.user, post]
  end
  
  def wrap(content)
    sanitize(raw(content.split.map{ |s| wrap_long_string(s) }.join(' ')))
  end
  
  private
    
    def wrap_long_string(text, max_width = 30)
      zero_width_space = '&#8203;'
      regex = /.{1,#max_width}/
      (text.length < max_width) ? text :
                                  text.scan(regex).join(zero_width_space)
    end
end
