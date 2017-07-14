import React from 'react';
import { Link } from 'react-router-dom';

export const PokemonIndexItem = ({key, pokemon}) => (
  <li key={key}>
    <Link to={`/pokemon/${pokemon.id}`}>
    {pokemon.id} <img src={pokemon.image_url} width="2%"></img> {pokemon.name}
    </Link>
  </li>
);
