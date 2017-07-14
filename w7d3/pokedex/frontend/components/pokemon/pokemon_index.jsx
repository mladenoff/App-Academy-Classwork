import React from 'react';
import { PokemonIndexItem } from './pokemon_index_item';
import { PokemonDetailContainer } from './pokemon_detail_container';
import { HashRouter, Route } from 'react-router-dom';

export class PokemonIndex extends React.Component {
  componentDidMount() {
    this.props.requestAllPokemon();
  }

  render() {
    const pokemonItems = this.props.pokemon.map(mon => <PokemonIndexItem key={mon.id} pokemon={mon} />);

    return (
      <div>
        <ul>
          {pokemonItems}
        </ul>
          <Route path="/pokemon/:pokemonId" component={ PokemonDetailContainer } />
      </div>
    );
  }
}
