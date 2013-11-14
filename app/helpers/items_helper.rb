module ItemsHelper
  def item_description(name, value)
    content_tag :tr, name do
      html  = content_tag :td, name
      html += content_tag :td, value
      html
    end if value.present?
  end
end
