import React from 'react';
import ReactDOM from 'react-dom';
import Root from './components/root';
import allTodos from './reducers/selectors';

import configureStore from './store/store';
import { receiveTodos, receiveTodo } from './actions/todo_actions';

document.addEventListener("DOMContentLoaded", () => {
  const store = configureStore();
  window.store = store;
  window.allTodos = allTodos;
  ReactDOM.render(<Root store={store} />, document.getElementById('content'));
});
