import React from 'react';
import ReactDOM from 'react-dom';
import { receiveAllPokemon, requestAllPokemon } from './actions/pokemon_actions';
import configureStore from './store/store';
import { selectAllPokemon } from './reducers/selectors';
import Root from './components/root';

import * as APIUtil from './util/api_util';


document.addEventListener('DOMContentLoaded', () => {
  const store = configureStore();
  window.getState = store.getState;
  window.dispatch = store.dispatch;
  const root = document.getElementById('root');
  ReactDOM.render(<Root store={store}/>, root);
});

window.fetchAllPokemon = APIUtil.fetchAllPokemon;
window.requestAllPokemon = requestAllPokemon;
window.receiveAllPokemon = receiveAllPokemon;
window.selectAllPokemon = selectAllPokemon;
