import { connect } from 'react-redux';
import TodoList from './todo_list';

import allTodos from '../../reducers/selectors';
import {receiveTodos, receiveTodo} from '../../actions/todo_actions';


const mapStateToProps = state => ({
  todos: allTodos(state),
  state
});

const mapDispatchToProps = dispatch => ({
  receiveTodos: () => dispatch(receiveTodos()),
  receiveTodo: (todo) => dispatch(receiveTodo(todo))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(TodoList);
