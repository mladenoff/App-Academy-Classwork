class User < ApplicationRecord
  validates :username, :password_digest, presence: true
  validates :username, :session_token, uniqueness: true
  validate :ensure_session_token

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end
end
