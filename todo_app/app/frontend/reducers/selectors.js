export const allTodos = ({ todos }) => {
  const keys = Object.keys(todos);
  return keys.map ((id) => {
    return todos[id];
  });
};
