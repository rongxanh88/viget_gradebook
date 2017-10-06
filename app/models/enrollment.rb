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

  
  def self.get_course_grades
    enrollments = Enrollment.all_enrollments_by_course
    add_avg_grades(enrollments)
  end
  
  def self.get_num_enrolled_by_semester
    enrollments = Enrollment.all_enrollments_by_course
    enrollments.group_by {|enrollment| enrollment.semester}
  end
  
  private

    def self.all_enrollments_by_course
      Enrollment.joins("INNER JOIN (" +
                Course.joins("INNER JOIN (" +
                      Semester.joins(:semester_courses)
                      .select("semester_courses.id AS id, semesters.name AS semester, semester_courses.course_id AS course_id")
                      .to_sql +
                      ") sem_courses ON sem_courses.course_id = courses.id"
                      ).select("sem_courses.id AS id, sem_courses.semester AS semester, courses.name AS course_name")
                      .to_sql +
                ") course_data ON course_data.id = enrollments.semester_course_id"
                ).select("course_data.id AS id, course_data.semester AS semester, course_data.course_name AS course_name, enrollments.grade AS grade")
    end
  
    def self.add_avg_grades(enrollments)
      course_enrollments = enrollments.group_by {|enrollment| enrollment.id}
      courses = enrollments.uniq {|enrollment| enrollment.id}
      avg_grades = course_enrollments.map do |course, enrollments|
        sum = enrollments.sum {|enrollment| enrollment.grade}
        sum / enrollments.count
      end
      courses.zip(avg_grades)
    end
end