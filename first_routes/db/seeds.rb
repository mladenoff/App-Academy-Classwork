User.destroy_all
Artwork.destroy_all
ArtworkShare.destroy_all

user1 = User.create( username: 'Anastassia' )
user2 = User.create( username: 'Isak' )
user3 = User.create( username: 'George' )

art1 = Artwork.create( title: 'Untitled', image_url: '281904', artist_id: user1.id)
art2 = Artwork.create( title: 'Untitled', image_url: '1905890434', artist_id: user2.id)
art3 = Artwork.create( title: 'White Square', image_url: '24785944', artist_id: user3.id)
art4 = Artwork.create( title: 'Blue Square', image_url: '2477744', artist_id: user3.id)
art5 = Artwork.create( title: 'Blue Circle', image_url: '777944', artist_id: user3.id)

share1 = ArtworkShare.create(artwork_id: art1.id, viewer_id: user2.id)
share2 = ArtworkShare.create(artwork_id: art5.id, viewer_id: user2.id)
share3 = ArtworkShare.create(artwork_id: art2.id, viewer_id: user1.id)
share4 = ArtworkShare.create(artwork_id: art1.id, viewer_id: user3.id)
share5 = ArtworkShare.create(artwork_id: art2.id, viewer_id: user3.id)
