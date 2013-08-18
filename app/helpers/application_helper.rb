module ApplicationHelper
  def connected_profile(user=current_user)
    Person.find_by_user_id(user)
  end
end
