@pokemon.each do |mon|
  json.set! mon.id do
    json.extract! mon, :id, :name
    json.image_url asset_path(mon.image_url)
  end
end
