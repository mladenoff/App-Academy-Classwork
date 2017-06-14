class AddIndex < ActiveRecord::Migration
  def change
    add_index(:enrollments, [:student_id, :course_id], unique: true)
  end
end
