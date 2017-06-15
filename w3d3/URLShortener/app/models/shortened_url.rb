class ShortenedUrl < ApplicationRecord
  validates :long_url, presence: true
  # validates :short_url, unique: true
  validates :user_id, presence: true

  has_one :submitter,
    primary_key: :user_id,
    foreign_key: :id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :Visit

  has_many :visitors,
    -> { distinct },
    source: :visitor,
    through: :visits

  def self.random_code
    output = SecureRandom.urlsafe_base64(16)
    while ShortenedUrl.exists?(:short_url => output)
      output = SecureRandom.urlsafe_base64(16)
    end
    output
  end

  def self.create_new(user, long_url)
    short_url = ShortenedUrl.random_code
    ShortenedUrl.create!({user_id: user.id, long_url: long_url, short_url: short_url})
    #.create! equivalent to .new and .save at the end
  end

  def num_clicks
    #counts number of clicks on ShortenedUrl
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    # self.visits.where({ created_at: (10.minutes.ago)..Time.now }).select(:user_id).distinct.count
    # SELECT * FROM users WHERE (created_at BETWEEN '2012-06-09 07:00:00.000000' AND '2012-06-10 07:00:00.000000'
    self.visitors.where({ created_at: (10.minutes.ago)..Time.now }).count
  end

end
