import React from 'react';
import TodoListItem from './todo_list_item';

const TodoList = ( { todos, receiveTodo } ) => (
    <ul>
      {
        todos.map(function(todo, idx) {
          return <TodoListItem todo={ todo }/>;
        })
      }
    </ul>
);

export default TodoList;
