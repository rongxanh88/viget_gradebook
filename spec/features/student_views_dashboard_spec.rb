require 'rails_helper'

RSpec.feature "Student", type: :feature do
  let(:teacher) {create(:user)}
  let(:student) {create(:user, role: 'student')}

  before(:each) do
    course = teacher.courses.create!(name: 'Calculus I')
    course1 = teacher.courses.create!(name: 'Physics I')
    course2 = teacher.courses.create!(name: 'Art History I')
    sem1 = Semester.create!(name: 'Spring 2017')
    sem1.courses << Course.all
    sem_course = SemesterCourse.find_by(course_id: course.id)
    sem_course1 = SemesterCourse.find_by(course_id: course1.id)
    sem_course2 = SemesterCourse.find_by(course_id: course2.id)

    student.enrollments.create!(grade: 100, semester_course_id: sem_course.id)
    student.enrollments.create!(grade: 90, semester_course_id: sem_course1.id)
    student.enrollments.create!(grade: 80, semester_course_id: sem_course2.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(student)
    visit(student_dashboard_index_path)
  end
  
  scenario "logs in and sees a list of courses by semester" do
    expect(page).to have_current_path('/student/dashboard')
    expect(page).to have_content("Logged in as #{student.username}")
    
    expect(page).to have_content('Calculus I')
    expect(page).to have_content('100')
  end
  
  scenario "can view GPA by semester" do
    expect(page).to have_current_path('/student/dashboard')
    
    expect(page).to have_content('Spring 2017')
    expect(page).to have_content('GPA: 90')
  end
end