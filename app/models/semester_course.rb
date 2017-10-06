class SemesterCourse < ApplicationRecord
  belongs_to :semester
  belongs_to :course
  has_many :enrollments

  def self.get_semester_course_id_by(course_id, semester)
    ids = Course.joins("INNER JOIN (" +
          Semester.joins(:semester_courses)
                  .where(name: semester)
                  .select("semester_courses.id AS semester_course_id, semester_courses.course_id")
                  .to_sql +
          ") sem_courses ON sem_courses.course_id = courses.id"
          ).where(id: course_id).select("sem_courses.semester_course_id AS sem_course_id")
          
    ids.first.sem_course_id
  end
end
