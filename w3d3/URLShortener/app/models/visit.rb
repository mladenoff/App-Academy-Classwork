class Visit < ApplicationRecord
  validates :user_id, presence: true
  validates :url_id, presence: true

  belongs_to :visitor,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User

  belongs_to :url,
  primary_key: :id,
  foreign_key: :url_id,
  class_name: :ShortenedUrl

  def self.record_visit!(user, shortened_url)
    # visit_count = 0
    # short_url = ShortenedUrl.random_code
    # ShortenedUrl.new({user_id: user.id, long_url: long_url, short_url: short_url})
    Visit.create!({user_id: user.id, url_id: shortened_url.id})
  end


end
