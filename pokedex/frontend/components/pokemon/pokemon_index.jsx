import React from 'react';

export class PokemonIndex extends React.Component {
  componentDidMount() {
    this.props.requestAllPokemon();
  }
  render() {
    const allPokemon = this.props.pokemon.map(mon =>
      <li key={mon.id}>
        <img src={mon.image_url} width="12%"></img>
        <br/>
        <strong>{mon.name}</strong>
      </li>
    );
    return (
      <div>
        <ul>
          {allPokemon}
        </ul>
      </div>
    );
  }
}
