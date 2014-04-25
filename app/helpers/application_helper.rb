module ApplicationHelper
  def link_to_add_fields(name, f, type) # ransack advanced search form
    new_object = f.object.send "build_#{type}"
    id = "new_#{type}"
    fields = f.send("#{type}_fields", new_object, child_index: id) do |builder|
      render(type.to_s + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def tagging_infos_for(obj)
    content_tag(:div, class: 'tagging-area') do 
	    for tag in obj.tags
	      concat content_tag :span, tag.name, class: 'label label-info'
	    end
    end if obj.tags.any?
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: false)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  def name_only_or_link_to(obj)
    unless obj.person
      obj.available_name
    else
      (link_to obj.available_name, obj.person).html_safe
    end
  end
end
