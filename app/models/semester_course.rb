class SemesterCourse < ApplicationRecord
  belongs_to :semester
  belongs_to :course
  has_many :enrollments
end
