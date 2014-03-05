module ControllerAspect
  def self.included(controller)
    controller.send :helper_method, :current_aspect, :aspect?
  end

  def current_aspect
    @current_aspect ||= Project.find(session[:project_id]) if session[:project_id]
  end

  def aspect?
    current_aspect
  end

end
