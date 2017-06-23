class Band < ApplicationRecord
  validates :name, uniqueness: true, presence: true

  has_many :albums, dependent: :destroy
  has_many :tracks, through: :albums
end
