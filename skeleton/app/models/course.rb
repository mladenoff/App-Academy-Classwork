class Course < ActiveRecord::Base

  validates :name, presence: true
  validates :instructor_id, presence: true

  has_many :enrollments,
    primary_key: :id,
    foreign_key: :course_id,
    class_name: :Enrollment

  has_many :enrolled_students,
    through: :enrollments,
    source: :users

  has_one :instructor,
    primary_key: :instructor_id,
    foreign_key: :id,
    class_name: :User

  has_one :prerequisite,
    primary_key: :prereq_id,
    foreign_key: :id,
    class_name: :Course


end
