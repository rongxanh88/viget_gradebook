require 'rails_helper'

RSpec.feature "Teacher", type: :feature do
  let(:user) {create(:user, role: :teacher)}

  before(:each) do
    user.courses.create!(name: 'Calculus I')
    sem1 = Semester.create!(name: 'Spring 2017')
    sem1.courses << Course.all

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit(teacher_dashboard_index_path)
  end

  scenario "logs in and sees a list of courses by semester" do
    expect(page).to have_current_path('/teacher/dashboard')
    expect(page).to have_content("Logged in as #{user.username}")

    expect(page).to have_content('Calculus I')
    expect(page).to have_content('Spring 2017')
  end

  scenario "clicks on a course and sees a students and his grades" do
    student = create(:user)
    course = user.courses.first
    sem_course = SemesterCourse.find_by(course_id: course.id)
    student.enrollments.create!(grade: 87, semester_course_id: sem_course.id)
    click_link(course.name)

    expect(page).to have_content(student.full_name)
    expect(page).to have_content(student.enrollments.first.grade)
  end
end