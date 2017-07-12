import React from 'react';
import { uniqueId } from '../../util/util';

class TodoForm extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      title: '',
      body: '',
      done: false
    };

    this.handleSubmit = this.handleSubmit.bind(this);
  }

  update(property){
    return event => this.setState({[property]: event.target.value});
  }

  handleSubmit (event) {
    // debugger;
    event.preventDefault();
    const todo = Object.assign({}, this.state, { id: uniqueId() });
    this.props.createTodo({ todo }).then(
      ()=>this.setState({ title: '', body: '' })
    );
  }

  render(){
    return (
      <form onSubmit={this.handleSubmit}>
        Title:
        <input
          type="text"
          value={this.state.title}
          onChange={this.update('title')}/>
        Body:
        <textarea onChange={this.update('body')} value={this.state.body}></textarea>
        <input type="submit" />
      </form>
    );
  }
}

export default TodoForm;
