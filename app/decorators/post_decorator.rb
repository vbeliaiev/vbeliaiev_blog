class PostDecorator < Draper::Decorator
  delegate_all

  def author_name
    user.decorate.display_name
  end

  def tags_links(css_wrapper_class: nil)
    return nil unless tags.present?
    h.content_tag :div, class: css_wrapper_class do
        tags.inject('')do |sum, tag|
          sum += h.content_tag :b do
            h.link_to('#' + tag.name, h.posts_path(tag_id: tag))
          end

          sum += ' '
          sum
        end.html_safe
    end


  end
end
