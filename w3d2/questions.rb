require "byebug"
require 'sqlite3'
require 'singleton'

class QuestionDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Question
  attr_accessor :title, :body, :user_id

  def initialize(datum)
    @id = datum['id']
    @title = datum['title']
    @body = datum['body']
    @user_id = datum['user_id']
  end

  def self.all
    data = QuestionDBConnection.instance.execute("SELECT * FROM questions")
    data.map { |datum| Question.new(datum) }
  end

  def self.find_by_id(id)
    datum = QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT *
      FROM questions
      WHERE id = ?
    SQL

    return nil if datum.empty?

    Question.new(datum.first)
  end

  def self.find_by_user_id(user_id)
    user = User.find_by_id(id)
    raise "#{user_id} not found in DB" unless user

    data = QuestionDBConnection.instance.execute(<<-SQL, user_id)
      SELECT *
      FROM questions
      WHERE user_id = ?
    SQL

    return nil if datum.empty?

    data.map { |datum| Question.new(datum) }
  end

  def self.find_by_title(title)
    data = QuestionDBConnection.instance.execute(<<-SQL, title)
      SELECT *
      FROM questions
      WHERE title = ?
    SQL

    return nil if data.empty?

    data.map { |datum| Question.new(datum) }
  end

  def author
    User.find_by_id(@user_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end
end

class Reply
  def initialize(datum)
    @id = datum["id"]
    @question_id = datum["question_id"]
    @parent_reply_id = datum["parent_reply"]
    @user_id = datum["user_id"]
    @body = datum["body"]
  end

  def self.all
    data = QuestionDBConnection.instance.execute("SELECT * FROM replies")
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_user_id(user_id)
    data = QuestionDBConnection.instance.execute(<<-SQL, user_id)
      SELECT *
      FROM replies
      WHERE user_id = ?
    SQL

    return nil if data.empty?

    data.map { |datum| Reply.new(datum)}
  end

  def self.find_by_id(id)
    datum = QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT *
      FROM replies
      WHERE id = ?
    SQL

    return nil if datum.empty?

    Reply.new(datum.first)
  end

  def self.find_by_question_id(question_id)
    data = QuestionDBConnection.instance.execute(<<-SQL, question_id)
      SELECT *
      FROM replies
      WHERE question_id = ?
    SQL

    return nil if data.empty?

    data.map { |datum| Reply.new(datum)}
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_reply_id) if @parent_reply_id
  end

  def child_replies
    data = QuestionDBConnection.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply = ?
    SQL

    return nil if data.empty?

    data.map { |datum| Reply.new(datum) }
  end
end

class User
  def initialize(datum)
    @id = datum["id"]
    @fname = datum["fname"]
    @lname = datum["lname"]
  end

  def self.all
    data = QuestionDBConnection.instance.execute("SELECT * FROM users")
    data.map { |datum| User.new(datum)}
  end

  def self.find_by_id(id)
    datum = QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT *
      FROM users
      WHERE id = ?
    SQL

    return nil if datum.empty?

    User.new(datum.first)
  end

  def self.find_by_name(fname, lname)
    data = QuestionDBConnection.instance.execute(<<-SQL, fname, lname)
      SELECT *
      FROM users
      WHERE fname = ? AND lname = ?
    SQL

    return nil if data.empty?

    data.map { |datum| User.new(datum)}
  end

  def self.find_by_fname(fname)
    data = QuestionDBConnection.instance.execute(<<-SQL, fname)
      SELECT *
      FROM users
      WHERE fname = ?
    SQL

    return nil if data.empty?

    data.map { |datum| User.new(datum)}
  end

  def self.find_by_lname(lname)
    data = QuestionDBConnection.instance.execute(<<-SQL, lname)
      SELECT *
      FROM users
      WHERE lname = ?
    SQL

    return nil if data.empty?

    data.map { |datum| User.new(datum)}
  end

  def authored_questions
    Question.find_by_user_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end
end

class QuestionFollow

  def initialize(datum)
    @id = datum['id']
    @user_id = datum['user_id']
    @question_id = datum['question_id']
  end

  def self.followers_for_question_id(question_id)
    data = QuestionDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        u.id, u.fname, u.lname
      FROM
        users u
      JOIN
        question_follows qf
        ON
          u.id = qf.user_id
      WHERE
        question_id = ?
    SQL

    return nil if data.empty?

    data.map { |datum| User.new(datum) }
  end

  def self.followed_questions_for_user_id(user_id)
    data = QuestionDBConnection.instance.execute(<<-SQL, user_id)
      SELECT
        q.id, q.title, q.body, q.user_id
      FROM
        questions q
        JOIN
          question_follows qf
          ON
            q.id = qf.question_id
      WHERE
        qf.user_id = ?
    SQL

    return nil if data.empty?

    data.map { |datum| Question.new(datum)}
  end

  def self.most_followed_questions(n)
    data = QuestionDBConnection.instance.execute(<<-SQL, n)
      SELECT
        q.id, q.title, q.body, q.user_id
      FROM
        questions q
      JOIN
        question_follows qf
        ON
          q.id = qf.question_id
      GROUP BY
        q.id
      ORDER BY
        COUNT(qf.user_id) DESC
      LIMIT ?
    SQL

  data.map { |datum| Question.new(datum) }
  end

end
