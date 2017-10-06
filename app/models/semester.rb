class Semester < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :semester_courses
  has_many :courses, through: :semester_courses
end
