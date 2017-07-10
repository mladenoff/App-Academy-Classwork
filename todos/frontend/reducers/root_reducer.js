import { combineReducers } from 'redux';
import todosReducer from './todos_reducer.js';
import allTodos

const rootReducer = combineReducers({
  todos: todosReducer
});

export default rootReducer;
