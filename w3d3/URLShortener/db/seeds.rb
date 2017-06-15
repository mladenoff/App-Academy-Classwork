# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# ActiveRecord::Base.transaction do
#
#   User.destroy_all
#   user1 = User.create(:name => "CJ")
#   user2 = User.create(:name => "Flarnie")
#   user3 = User.create(:name => "Jeff")
#   user4 = User.create(:name => "Georges St. Pierre")
#   user5 = User.create(:name => "Ned")
#
#   Course.destroy_all
#   course1 = Course.create(:name => "Ruby 101", :instructor_id => user5.id)
#   course2 = Course.create(:name => "Ruby 102", :instructor_id => user5.id, prereq_id: course1.id)
#
#   Enrollment.destroy_all
#   Enrollment.create(:student_id => user3.id, :course_id => course1.id)
#   Enrollment.create(:student_id => user4.id, :course_id => course1.id)
#   Enrollment.create(:student_id => user1.id, :course_id => course2.id)
#   Enrollment.create(:student_id => user2.id, :course_id => course2.id)
#
# end

ActiveRecord::Base.transaction do

  User.destroy_all
  user1 = User.create(:email => "johndoe@gmail.com")
  user2 = User.create(:email => "johndoe2@gmail.com")
  user3 = User.create(:email => "janedoe@gmail.com")
  user4 = User.create(:email => "janedoe2@gmail.com")
  user5 = User.create(:email => "crap123@gmail.com")

  ShortenedUrl.destroy_all
  url1 = ShortenedUrl.create(:long_url => "http://www.google.com/asdfasdfasdfsdf/asdf", :short_url => "abc", :user_id => user1.id)
  url2 = ShortenedUrl.create(:long_url => "http://www.google.com/wooorails/asdf", :short_url => "abcd", :user_id => user3.id)
  url3 = ShortenedUrl.create(:long_url => "http://www.google.com/whatagreatday/asdf", :short_url => "abce", :user_id => user2.id)
  url4 = ShortenedUrl.create(:long_url => "http://www.google.com/tissuepaper/asdf", :short_url => "abcfg", :user_id => user5.id)

  Visit.destroy_all
  visit1 = Visit.create(:user_id => user4.id, :url_id => url2.id)
  visit2 = Visit.create(:user_id => user5.id, :url_id => url4.id)
  visit3 = Visit.create(:user_id => user5.id, :url_id => url4.id)
  visit4 = Visit.create(:user_id => user2.id, :url_id => url1.id)




end
