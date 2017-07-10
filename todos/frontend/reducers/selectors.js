export const allTodos = (state) => {
  const todos = Object.keys(state.todos);
  return todos.map ((el) => {
    return state.todos[el].title;
  });
};
