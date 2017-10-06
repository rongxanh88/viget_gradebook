require 'rails_helper'

RSpec.feature "Administrator", type: :feature do
  let(:admin) {create(:user, role: 'admin')}

  before(:each) do
    teacher = create(:user, role: 'teacher')
    semester = Semester.create!(name: 'Spring 2017')
    semester.courses << teacher.courses.create!(name: 'Calculus I')
    sem_course = SemesterCourse.first
    3.times do |n|
      create(:enrollment, grade: 10 * n, semester_course_id: sem_course.id)
    end

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit(admin_dashboard_index_path)
  end
  
  scenario "logs in and sees a list of courses by semester and avg gpa" do
    expect(page).to have_current_path('/admin/dashboard')
    expect(page).to have_content("Logged in as #{admin.username}")

    expect(page).to have_content("Calculus I")
    expect(page).to have_content("Spring 2017")
    expect(page).to have_content("20")
  end

  scenario "sees number of enrollments by semester" do
    expect(page).to have_current_path('/admin/dashboard')

    expect(page).to have_content("Spring 2017")
    expect(page).to have_content("Number enrolled: 3")
  end
end