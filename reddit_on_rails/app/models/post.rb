# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  validates :title, :author, :subs, presence: true

  has_many :post_subs
  has_many :subs, through: :post_subs

  belongs_to :author,
    # foreign_key: :author_id,
    class_name: :User

  has_many :comments
end
