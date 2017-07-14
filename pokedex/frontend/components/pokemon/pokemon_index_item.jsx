import React from 'react';
import { Link } from 'react-router-dom';

export const PokemonIndexItem = ({key, pokemon}) => (
  <li key={key}>
    <Link to="/pokemon/:pokemonId">
    <img src={pokemon.image_url} width="15%"></img>
    <br/>
    {pokemon.name}
    </Link>
  </li>
);
