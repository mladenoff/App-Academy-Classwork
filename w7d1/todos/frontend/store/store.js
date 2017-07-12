import { createStore } from 'redux';
import rootReducer from '../reducers/root_reducer';
import { receiveTodos, receiveTodo } from '../actions/todo_actions';

const configureStore = () => (
  createStore(rootReducer)
);

export default configureStore;
