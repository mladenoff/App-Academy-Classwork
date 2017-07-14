export const fetchAllPokemon = () => (
  $.ajax({
    type: 'GET',
    url: 'api/pokemon'
  })
);

export const fetchSinglePokemon = id => (
  $.ajax({
    type: 'GET',
    url: `api/pokemon/${id}`
  })
);
