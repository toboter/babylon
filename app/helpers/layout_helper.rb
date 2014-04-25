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

  def footer_section(var)
    content_for(:footer_section) {
      content_tag :div, class: 'span12', style: 'border-top:1px solid #f5f5f5; margin-top:50px; padding-top:10px;' do
        content_tag :p, ('Written by '+h(name_only_or_link_to(var.updater))+(var.created_at != var.updated_at ? (' [Updated '+distance_of_time_in_words_to_now(var.updated_at)+' ago]') : (' ['+distance_of_time_in_words_to_now(var.created_at)+' ago]'))).html_safe
      end
    }
  end

  def edit_section_for(var, polymorphic=nil, polymorphicl2=nil)
    edit = h(link_to image_tag("icons/edit1.svg", class: 'navbar-icon', style: 'width:20px;margin-left:5px;'), [:edit, polymorphicl2, polymorphic, var], title: 'Edit', class: 'tooltip-bottom')
    delete = h(link_to image_tag("icons/delete7.svg", class: 'navbar-icon', style: 'width:20px;margin-left:10px;'), [polymorphicl2, polymorphic, var], method: :delete, title: 'Delete', data: { confirm: 'Are you sure?' }, class: 'tooltip-bottom')
    content_for(:edit_section) { 
        if (can? :edit, var && (can? :destroy, var)) || (var.creator == current_user)
          edit + delete 
        elsif can? :edit, var || (var.creator == current_user)
          edit
        elsif (can? :destroy, var) || (var.creator == current_user)
          delete
        else
          ''
        end
    }
  end

  def publishing_section_for(var)
    content_for(:publishing_section) { 
      render 'shared/publishing', var: var
    } if can? :manage, 'publishing'
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