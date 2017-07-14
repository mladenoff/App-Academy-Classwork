import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import Root from './components/root';
import { HashRouter, Route } from 'react-router-dom';
import * as APIUtil from './util/api_util';


document.addEventListener('DOMContentLoaded', () => {
  const store = configureStore();
  window.getState = store.getState;
  window.dispatch = store.dispatch;
  const root = document.getElementById('root');
  ReactDOM.render(<Root store={store}/>, root);
});


import { requestSinglePokemon } from './actions/pokemon_actions';
// import { selectSinglePokemon } from './reducers/selectors';

// window.fetchSinglePokemon = APIUtil.fetchSinglePokemon;
window.requestSinglePokemon = requestSinglePokemon;
// window.receiveSinglePokemon = receiveSinglePokemon;
// window.selectAllPokemon = selectAllPokemon;

// getState(); // should return initial app state
//
// const getSuccess = pokemon => dispatch(receiveSinglePokemon(pokemon));
// fetchSinglePokemon(7).then(getSuccess);
//
// getState(); // should return the app state populated with pokemon
