import * as APIUtil from '../util/api_util';

//action types
export const RECEIVE_ALL_POKEMON = "RECEIVE_ALL_POKEMON";

//sync
export const receiveAllPokemon = pokemon => ({
  type: RECEIVE_ALL_POKEMON,
  pokemon
});

//async
export const requestAllPokemon = () => (dispatch) => {
  return APIUtil.fetchAllPokemon()
    .then(pokemon => dispatch(receiveAllPokemon(pokemon)));
};
