class Admin::DashboardController < Admin::AuthorizationController
  
  def index
    @course_grades = Enrollment.get_course_grades
    @num_enrolled = Enrollment.get_num_enrolled_by_semester
  end

end