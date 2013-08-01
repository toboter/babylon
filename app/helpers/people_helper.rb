module PeopleHelper

  def graded_fullname(person)
  	if person.grade
  	  if person.grade == 'Prof. Dr.' || person.grade == 'Dr.'
  	  	person.grade + ' ' + person.fullname
  	  elsif person.grade == 'M.A.'
  	  	person.fullname + ' (' + person.grade + ')'
  	  else
  	  	person.fullname
  	  end
  	end
  end

  def prepend(icon, lft=nil)
    if lft.nil?
      style = 'padding-right:10px'
    else
      style = 'padding-right:10px; margin-left:'+lft+';'
    end
    content_tag :i, '', class: 'foundicon-'+icon, style: style
  end
  	  		
end
