class Album < ApplicationRecord
  validates :name, presence: true

  has_many :tracks, dependent: :destroy
  belongs_to :band
end
