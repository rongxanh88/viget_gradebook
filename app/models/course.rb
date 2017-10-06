class Course < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  belongs_to :user
  has_many :semester_courses
  has_many :semesters, through: :semester_courses
end
