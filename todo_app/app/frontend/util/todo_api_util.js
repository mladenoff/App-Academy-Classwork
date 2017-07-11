export const fetchRequest = () => {
  return $.ajax({ method: 'GET', url: '/api/todos' });
};

window.fetchRequest = fetchRequest;
