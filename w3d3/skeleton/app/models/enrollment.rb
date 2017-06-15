class Enrollment < ActiveRecord::Base
  validates :course_id, presence: true
  validates :student_id, presence: true

  belongs_to :user,
  primary_key: :id,
  foreign_key: :student_id,
  class_name: :User

  belongs_to :course,
  primary_key: :id,
  foreign_key: :course_id,
  class_name: :Course
end
