import { connect } from 'react-redux';
import { selectAllPokemon } from '../../reducers/selectors';
import { requestSinglePokemon } from '../../actions/pokemon_actions';
import { PokemonDetail } from './pokemon_detail';


const mapStateToProps = state => ({
  pokemon: state.pokemon.entities[state.pokemon.currentMon]
});

const mapDispatchToProps = dispatch => ({
  requestSinglePokemon: () => dispatch(requestSinglePokemon())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(PokemonDetail);
