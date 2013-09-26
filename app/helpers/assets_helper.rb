module AssetsHelper
  def asset_description(name, value, value2=nil)
  	if value2
  	  value = value.to_s + ' x ' + value2.to_s
  	end
    content_tag :dt, name do
      html  = content_tag :dt, name, class: 'muted'
      html += content_tag :dd, value
      html
    end if value.present?
  end
end
