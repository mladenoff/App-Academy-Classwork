import React from 'react';
import { uniqueId } from '../../util/util';

class TodoForm extends React.Component {
  constructor(props){
    super(props);
    this.props = props;
    this.state = {
      title: '',
      body: '',
      done: false
    };

    this.submitTodo = this.submitTodo.bind(this);
  }

  linkState(key){
    return (event => this.setState({[key]: event.currentTarget.value}));
  }

  submitTodo (event) {
    event.preventDefault();
    const todo = Object.assign({}, this.state, { id: uniqueId() });
    this.props.receiveTodo(todo);
    this.setState({
      title: '',
      body: ''
    });
  }

  render(){
    return (
      <form onSubmit={this.submitTodo}>
        Title:
        <input
          type="text"
          value={this.state.title}
          onChange={this.linkState('title')}/>
        Body:
        <textarea onChange={this.linkState('body')} value={this.state.body}></textarea>
        <input type="submit" />
      </form>
    );
  }
}

export default TodoForm;
