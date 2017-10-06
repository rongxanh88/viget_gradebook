class Enrollment < ApplicationRecord
  validates :grade, presence: true
  
  belongs_to :user
  belongs_to :semester_course
end
