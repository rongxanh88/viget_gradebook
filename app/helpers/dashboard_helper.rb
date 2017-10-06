module DashboardHelper
  def to_css_class(course)
    if course.semester
      return "#{course.semester.split(' ').join('_')}"
    end
  end
end