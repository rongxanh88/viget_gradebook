class Teacher::CoursesController < Teacher::AuthorizationController
  
  def show
    @students = User.students_in_course(params[:id], semester_params)
  end

  private
  
    def semester_params
      params.require(:semester).permit(:semester)
    end

end