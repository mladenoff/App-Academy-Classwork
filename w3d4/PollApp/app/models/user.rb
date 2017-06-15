class User < ApplicationRecord

  has_many :authored_polls,
    class_name: "Poll",
    primary_key: :id,
    foreign_key: :author_id

  has_many :responses,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id

end
