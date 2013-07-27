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
  	  		
end
