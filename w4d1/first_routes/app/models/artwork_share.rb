class ArtworkShare < ActiveRecord::Base
  validates :artwork_id, presence: true
  validates :viewer_id, presence: true, uniqueness: { scope: :artwork_id,
    message: "Each view may only have 1 share per artwork." }

  belongs_to :viewer,
    primary_key: :id,
    foreign_key: :viewer_id,
    class_name: :User

  belongs_to :artwork,
    primary_key: :id,
    foreign_key: :artwork_id,
    class_name: :Artwork
end
