import * as APIUtil from '../util/todo_api_util';

export const RECEIVE_TODOS = "RECEIVE_TODOS";
export const RECEIVE_TODO = "RECEIVE_TODO";
export const REMOVE_TODO = "REMOVE_TODO";


export const receiveTodos = (todos) => {
  return {
    type: RECEIVE_TODOS,
    todos
  };
};

export const receiveTodo = (todo) => {
  return {
    type: RECEIVE_TODO,
    todo
  };
};

export const removeTodo = (todo) => {
  return {
    type: REMOVE_TODO,
    todo
  };
};

export const fetchTodos = () => {
  return (dispatch) => {
    APIUtil.fetchTodos().then((data)=>{dispatch(receiveTodos(data));});
  };
};

export const createTodo = (todo) => {
  return (dispatch) => {
    APIUtil.createTodo(todo).then(data => dispatch(receiveTodo(data)));
  };
};

window.fetchTodos = fetchTodos;
