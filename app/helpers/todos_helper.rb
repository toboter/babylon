module TodosHelper

  def due_to_state(obj)
  	obj > DateTime.now ?  ' left' : ' overdue'
  end

  def starts_at_state(obj)
  	obj > DateTime.now ?  'Can start in ' : 'Start is overdue since '
  end
end
