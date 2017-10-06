class CreateSemesterCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :semester_courses do |t|
      t.references :semester, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
