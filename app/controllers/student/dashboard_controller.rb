class Student::DashboardController < Student::AuthorizationController
  
  def index
    @course_grades = Course.courses_enrolled(current_user)
    @semester_gpa = Enrollment.semester_gpas
  end

end