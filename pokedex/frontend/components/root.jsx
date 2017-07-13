import React from 'react';
import { Provider } from 'react-redux';
import PokemonIndexContainer from './pokemon/pokemon_index_container';

const Root = ({ store }) => (
  <Provider store={store}>
    <div>Hello, Magikarp!!
      <PokemonIndexContainer />
    </div>
  </Provider>
);

export default Root;
