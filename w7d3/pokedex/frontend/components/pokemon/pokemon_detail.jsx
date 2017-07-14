import React from 'react';

export class PokemonDetail extends React.Component {
  componentDidMount(){
    this.props.requestSinglePokemon(this.props.match.params.pokemonId);
  }

  render() {
    console.log(this.props);
    return (
      <div>{this.props.pokemon.name}</div>
    );
  }
}
