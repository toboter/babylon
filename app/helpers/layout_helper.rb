# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
  def title(page_title, page_subtitle, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    content_for(:subtitle) { h(page_subtitle.to_s) }
    @show_title = show_title
  end

  def edit_section_for(var, polymorphic, polymorphicl2=nil)
    content_for(:edit_section) { 
      content_tag :li, 
        h(link_to image_tag("icons/edit1.svg", class: 'navbar-icon', style: 'width:20px;margin-left:5px;'), [:edit, polymorphicl2, polymorphic, var], title: 'Edit') + 
        h(link_to image_tag("icons/delete7.svg", class: 'navbar-icon', style: 'width:20px;margin-left:10px;'), [polymorphicl2, polymorphic, var], method: :delete, title: 'Delete', data: { confirm: 'Are you sure?' })
    }
  end

  def show_title?
    @show_title
  end

  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end

  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end

  def what_alert(name)
    name.to_s == 'notice' ? 'alert-success' : nil # or just nil for a warning or alert-info
  end
end