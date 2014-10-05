module TagsHelper
  def tags_link(post)
    return unless post.tags.any?
    post.tags.map(&:name).map { |t| content_tag "li", link_to(t, tag_path(t)) }.join(' ').html_safe
  end
end
