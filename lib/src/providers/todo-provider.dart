import 'package:flutter/material.dart';
import 'package:todo_list/src/models/todo.dart';
import 'package:todo_list/src/services/todo-service-sqflite.dart';

//* Todo provider
class TodoProvider extends ChangeNotifier {

  final TodoServiceSQFLite _todoServiceDb = TodoServiceSQFLite.instance;
  final List<Todo> _todos = List<Todo>();

  //* Listado de Tareas
  Future<List<Todo>> getTodos() async {
    if (_todos.isNotEmpty) {      
      return _todos;
    }
    var todos = await _todoServiceDb.getTodos();
    _todos.addAll(todos);
    return _todos;
  }

  Todo getTodoByIndex(int index) {
    return _todos[index];
  }

  addTodo(Todo todo) async {
    await _todoServiceDb.addTodo(todo);
    var todos = await _todoServiceDb.getTodos();
    _todos..clear()..addAll(todos);
    notifyListeners();
  }

  deleteTodo(int index) async {
    await _todoServiceDb.deleteTodo(_todos[index].name);
    _todos.removeAt(index);
    notifyListeners();
  }

  updateTodo(int index, Todo todo) {
    _todoServiceDb.updateTodo(todo);
    _todos[index] = todo;
    notifyListeners();
  }

}