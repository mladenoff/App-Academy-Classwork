# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

isak = User.create!(user_name: "isak")
zach = User.create!(user_name: "darklink_sephiroth1337_360_no_scope")

poll1 = Poll.create!(author_id: zach.id, title: "yeah..umm....yeah")

question1 = Question.create!(poll_id: poll1.id, body: "What the hell is this poll?")
question2 = Question.create!(poll_id: poll1.id, body: "Where the hell is this poll?")
question3 = Question.create!(poll_id: poll1.id, body: "How the hell is this poll?")

answer_choice1 = AnswerChoice.create!(question_id: question1.id, body: "Wouldn't you like to know.")
answer_choice2 = AnswerChoice.create!(question_id: question1.id, body: "Curiosity killed the cat.")
answer_choice3 = AnswerChoice.create!(question_id: question2.id, body: "You'll never find it.")
answer_choice4 = AnswerChoice.create!(question_id: question2.id, body: "Spear and Howard.")
answer_choice5 = AnswerChoice.create!(question_id: question3.id, body: "Fine.")
answer_choice6 = AnswerChoice.create!(question_id: question3.id, body: "How not?")

response1 = Response.create!()
