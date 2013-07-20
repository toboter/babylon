module ApplicationHelper
  def connected_profile
    Person.find_by_user_id(current_user)
  end
end
