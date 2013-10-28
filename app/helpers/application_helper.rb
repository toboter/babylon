module ApplicationHelper
  def link_to_add_fields(name, f, type)
    new_object = f.object.send "build_#{type}"
    id = "new_#{type}"
    fields = f.send("#{type}_fields", new_object, child_index: id) do |builder|
      render(type.to_s + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def tagging_infos_for(obj)
    content_tag(:span, class: 'pull-right') do 
	  for tag in obj.tags
	    concat content_tag :span, tag.name, class: 'label label-info', style: 'margin-left:5px;'
	  end
    end if obj.tags.any?
  end
end
