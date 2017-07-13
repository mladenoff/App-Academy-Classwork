import React from 'react';
import ReactDOM from 'react-dom';
import { receiveAllPokemon } from './actions/pokemon_actions';

import * as APIUtil from './util/api_util';

window.fetchAllPokemon = APIUtil.fetchAllPokemon;
window.receiveAllPokemon = receiveAllPokemon;

document.addEventListener('DOMContentLoaded', () => {
  const rootEl = document.getElementById('root');
  ReactDOM.render(<h1>Pokémon</h1>, rootEl);
});
