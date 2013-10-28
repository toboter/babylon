module AssetsHelper
  def asset_description(name, value, value2=nil)
  	if value2
  	  value = value.to_s + ' x ' + value2.to_s
  	end
    content_tag :tr, name do
      html  = content_tag :td, name
      html += content_tag :td, value
      html
    end if value.present?
  end
end
