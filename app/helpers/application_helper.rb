module ApplicationHelper
  def link_to_add_fields(name, f, type) # ransack advanced search form
    new_object = f.object.send "build_#{type}"
    id = "new_#{type}"
    fields = f.send("#{type}_fields", new_object, child_index: id) do |builder|
      render(type.to_s + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def tagging_infos_for(obj, cssoptions=nil)
    content_tag(:div, class: "tagging-area #{cssoptions}", style: 'margin: 0 10px;') do 
	    content_tag :span, obj.tags.map{|t| link_to(t.name, t, style: 'color: white; font-weight:bold;')}.join(', ').html_safe, class: 'label label-info'
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
