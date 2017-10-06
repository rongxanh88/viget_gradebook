class User < ApplicationRecord
  validates :full_name, :username, :role, :password_digest, presence: true
  validates :username, uniqueness: true

  has_secure_password

  enum role: [:student, :teacher, :admin]
  
  has_many :enrollments
  has_many :courses
end
