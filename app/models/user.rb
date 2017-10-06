class User < ApplicationRecord
  validates :full_name, :username, :role, :password_digest, presence: true
  validates :username, uniqueness: true

  has_secure_password

  enum role: [:student, :teacher, :admin]
  
  has_many :enrollments
  has_many :courses

  def self.students_in_course(course_id, semester_params)
    sem_course_id = SemesterCourse.get_semester_course_id_by(
                                          course_id, semester_params[:semester]
                                        )
              
    User.joins("INNER JOIN (" +
      SemesterCourse.joins(:enrollments)
                    .where(id: sem_course_id)
                    .select("enrollments.id, enrollments.user_id AS user_id, enrollments.grade AS grade")
                    .to_sql +
      ") course_enrollments ON course_enrollments.user_id = users.id"
      ).select("users.id, users.full_name, course_enrollments.grade AS grade")
  end
end
