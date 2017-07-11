import React from 'react';

class TodoListItem extends React.Component {
  constructor (props){
    super(props);
    // debugger;
    this.todo = props.todo;
  }

  render(){
    return (<li>{this.todo.title}</li>);
  }
}

export default TodoListItem;
