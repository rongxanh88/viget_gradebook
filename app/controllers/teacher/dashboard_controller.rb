class Teacher::DashboardController < Teacher::AuthorizationController
  
  def index
    @courses = Course.instructor_courses(current_user)
  end

end