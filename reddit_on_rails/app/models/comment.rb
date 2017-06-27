class Comment < ApplicationRecord
  validates :content, :author, :post, presence: true

  belongs_to :author, foreign_key: :author_id, class_name: :User
  belongs_to :post
  has_many :child_comments,
    foreign_key: :parent_comment_id,
    class_name: :Comment


end
