module PeopleHelper

  def graded_fullname(person)
  	if person.grade
  	  if person.grade == 'Prof. Dr.' || person.grade == 'Dr.'
  	  	person.grade + ' ' + person.name
  	  elsif person.grade == 'M.A.'
  	  	person.name + ' (' + person.grade + ')'
  	  else
  	  	person.name
  	  end
  	end
  end

  def prepend(icon, lft=nil)
    if lft.nil?
      style = 'padding-right:10px'
    else
      style = 'padding-right:10px; margin-left:'+lft+';'
    end
    content_tag :i, '', class: 'icon-'+icon, style: style
  end
	
end
