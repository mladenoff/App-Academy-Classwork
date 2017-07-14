import React from 'react';
import { PokemonIndexItem } from './pokemon_index_item';

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
      </div>
    );
  }
}
