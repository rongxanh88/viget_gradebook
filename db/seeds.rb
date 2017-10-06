class Seed
  
    def self.start
      admin
      students(50)
      teachers
      courses
      semesters
      semester_courses
      enrollments
    end
  
    def self.admin
      User.create!(
        full_name: 'Admin User',
        username: 'admin',
        password: 'password',
        role: 'admin'
        )
      puts "admin created"
    end
  
    def self.students(number_of_students)
      (number_of_students).times do |n|
        student = User.create!(
          full_name: Faker::Name.name,
          username: "student#{n}",
          password: 'password',
          role: 'student'
          )
        puts "#{student.full_name} created!"
      end
    end
  
    def self.teachers
      (3).times do |n|
        teacher = User.create!(
          full_name: "Instructor #{Faker::Name.name}",
          username: "teacher#{n}",
          password: 'password',
          role: 'teacher'
        )
        puts "#{teacher.full_name} created!"
      end
    end
    
    def self.courses
      teachers = User.where(role: 'teacher')
      teachers[0].courses.create!(name: 'Calculus I')
      teachers[1].courses.create!(name: 'Physics I')
      teachers[2].courses.create!(name: 'History of Art I')
      puts "seeded #{Course.count} courses"
    end
  
    def self.semesters
      Semester.create!(name: 'Spring 2017')
      Semester.create!(name: 'Fall 2017')
      puts "seeded #{Semester.count} semesters"
    end
  
    def self.semester_courses
      semesters = Semester.all
      semesters.each do |semester|
        semester.courses << Course.all
      end
      puts "All courses added to each semester"
    end
  
    def self.enrollments
      self.seed_enrollments('Spring 2017')
      self.seed_enrollments('Fall 2017')
    end
  
    def self.seed_enrollments(semester)
      gen = Random.new
      students = User.where(role: 'student')
      ids = SemesterCourse.where(semester_id: Semester.where(name: semester).pluck(:id))
                          .pluck(:id)
  
      ids.each do |id|
        students.each do |student|
          student.enrollments.create!(
            semester_course_id: id,
            grade: (semester == 'Spring 2017' ? gen.rand(30.59) : gen.rand(70..100))
            )
          puts "#{student.full_name} enrollments seeded"
        end
      end
    end
  end
  
  Seed.start