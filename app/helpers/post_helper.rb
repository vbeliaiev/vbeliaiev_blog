module PostHelper
  def post_tags_links(post, css_wrapper_class: nil)
    tags = post.tags
    return nil unless tags.present?

    content_tag :div, class: css_wrapper_class do
      tags.inject('') do |sum, tag|
        sum += content_tag :b do
          link_to("##{tag.name}", posts_path(tag_id: tag))
        end

        sum += ' '
        sum
      end.html_safe
    end
  end
end
