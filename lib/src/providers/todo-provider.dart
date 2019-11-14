import 'package:flutter/material.dart';
import 'package:todo_list/src/models/todo.dart';
import 'package:todo_list/src/services/todo-service.dart';

//* Todo provider
class TodoProvider extends ChangeNotifier {

  final TodoService _todoService = TodoService();

  //* Listado de Tareas
  List<Todo> getTodos() {
    return _todoService.getTodos();
  }

  Todo getTodoByIndex(int index) {
    return _todoService.getTodoByIndex(index);
  }

  addTodo(Todo todo) {
    _todoService.addTodo(todo);
    notifyListeners();
  }

  deleteTodo(int index){
    _todoService.deleteTodo(index);
    notifyListeners();
  }

  updateTodo(int index, Todo todo) {
    _todoService.updateTodo(index, todo);
    notifyListeners();
  }

}