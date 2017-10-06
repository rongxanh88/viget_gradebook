class Enrollment < ApplicationRecord
  validates :grade, presence: true
  
  belongs_to :user
  belongs_to :semester_course

  def self.semester_gpas(user)
    Enrollment.joins(
      "INNER JOIN (" +
      Semester.joins(:semester_courses)
              .select("semester_courses.id AS id, semesters.name AS name")
              .to_sql +
      ") sem_courses ON sem_courses.id = enrollments.semester_course_id"
      ).where("enrollments.user_id = #{user.id}")
      .select("sem_courses.name AS semester, AVG(enrollments.grade) AS GPA")
      .group("semester")
  end
end
