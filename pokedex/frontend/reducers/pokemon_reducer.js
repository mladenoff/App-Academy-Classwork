import { RECEIVE_ALL_POKEMON, RECEIVE_SINGLE_POKEMON } from '../actions/pokemon_actions';

const pokemonReducer = (state = {}, action) => {
  Object.freeze(state);
  let nextState;

  switch(action.type) {
    case RECEIVE_ALL_POKEMON:
      return Object.assign({}, state, {entities: action.pokemon});
    case RECEIVE_SINGLE_POKEMON:
      return {
        currentMon: action.pokemon.mon.id,
        entities: Object.assign(
          {},
          state.entities,
          {[action.pokemon.mon.id]: action.pokemon.mon}
        )
      };
    default:
      return state;
  }
};

export default pokemonReducer;
