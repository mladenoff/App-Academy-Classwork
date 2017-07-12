import { RECEIVE_TODOS, RECEIVE_TODO, REMOVE_TODO } from '../actions/todo_actions';
import { merge } from 'lodash';

// const initialState = {
//   1: {
//     id: 1,
//     title: "wash car",
//     body: "with soap",
//     done: false
//   },
//   2: {
//     id: 2,
//     title: "wash dog",
//     body: "with shampoo",
//     done: true
//   },
// };

const todosReducer = function(state = {}, action) {
  // debugger;
  Object.freeze(state);
  switch (action.type) {
    case RECEIVE_TODOS:
      let newState = {};
      for (var i = 0; i < action.todos.length; i++) {
        newState[i+1] = action.todos[i];
      }
      return newState;

    case RECEIVE_TODO:
      const todo = action.todo;
      return merge({}, state, { [todo.id]: todo });

    case REMOVE_TODO:
      let nextState = merge({}, state);
      delete nextState[action.todo.id];
      return nextState;

    default:
      return state;
  }
};

export default todosReducer;
//
// const newTodos = [
//   { id: 1,     title: "wash house",
//       body: "with grease",
//       done: false },
//   { id: 2,     title: "wash cat",
//       body: "with shampoo",
//       done: true }
// ]
