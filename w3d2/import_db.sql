CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_reply INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_reply) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Alex', 'Park'),
  ('Isak', 'Mladenoff');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('Who?', 'who', (SELECT id FROM users WHERE fname = 'Alex')),
  ('What?', 'what', (SELECT id FROM users WHERE fname = 'Isak'));

INSERT INTO
  question_follows (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Isak'), (SELECT id FROM questions WHERE title = 'Who?')),
  ((SELECT id FROM users WHERE fname = 'Alex'), (SELECT id FROM questions WHERE title = 'What?')),
  ((SELECT id FROM users WHERE fname = 'Isak'), (SELECT id FROM questions WHERE title = 'What?'));

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Alex'), (SELECT id FROM questions WHERE title = 'Who?')),
  ((SELECT id FROM users WHERE fname = 'Alex'), (SELECT id FROM questions WHERE title = 'What?'));

INSERT INTO
  replies (user_id, question_id, body, parent_reply)
VALUES
  ((SELECT id FROM users WHERE fname = 'Isak'), (SELECT id FROM questions WHERE title = 'Who?'), ("Kelly"), (NULL));

INSERT INTO
  replies (user_id, question_id, body, parent_reply)
VALUES
  ((SELECT id FROM users WHERE fname = 'Isak'), (SELECT id FROM questions WHERE title = 'Who?'), ("Hashbrowns"), (SELECT id FROM replies WHERE body = "Kelly"));

  -- SELECT body FROM replies
  --   JOIN users
  --     ON replies.user_id = users.id
  -- WHERE users.fname = "Isak";

-- SELECT q.title FROM questions q
--   JOIN question_follows qf
--     ON q.id = qf.question_id
--   JOIN users u
--     ON u.id = qf.user_id
-- WHERE u.fname = "Isak";
