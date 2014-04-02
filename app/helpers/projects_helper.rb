module ProjectsHelper

  def full_qualified_name(project)
    if project.projectable_type == "Group"
      project.projectable.cluster.name + ' / ' + project.projectable.name + ' / ' + project.name
    else
      project.projectable.name + ' / ' + project.name
    end
  end

end