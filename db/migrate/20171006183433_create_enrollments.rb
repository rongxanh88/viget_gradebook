class CreateEnrollments < ActiveRecord::Migration[5.1]
  def change
    create_table :enrollments do |t|
      t.references :user
      t.references :semester_course
      t.integer :grade
      
      t.timestamps
    end
  end
end
