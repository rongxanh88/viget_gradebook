class Course < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  belongs_to :user
  has_many :semester_courses
  has_many :semesters, through: :semester_courses

  def self.courses_enrolled(user)
    Course.joins("INNER JOIN (" +
          SemesterCourse.joins(:enrollments)
                        .where("enrollments.user_id = #{user.id}")
                        .select("enrollments.grade AS grade, semester_courses.course_id AS course_id")
                        .to_sql +
                        ") sem_courses ON sem_courses.course_id = courses.id"
                        ).select("courses.name, sem_courses.grade")
  end
end
