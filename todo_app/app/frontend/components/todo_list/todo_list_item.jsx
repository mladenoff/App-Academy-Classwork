import React from 'react';

class TodoListItem extends React.Component {
  constructor (props){
    super(props);
    this.removeTodo = props.removeTodo;
    this.receiveTodo = props.receiveTodo;
    this.todo = props.todo;
  }

  done(){
    let done = !this.todo.done;
    this.todo.done = done;
    this.receiveTodo(this.todo);
  }

  render(){
    return (<li>{this.todo.title} <button onClick={this.done.bind(this)}>
        {this.todo.done ? "done" : "not done"}
      </button> <button
        onClick={this.removeTodo.bind(this, this.todo)}>
        Remove Todo
      </button>

      </li>);
  }
}

export default TodoListItem;
