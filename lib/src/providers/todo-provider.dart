import 'package:flutter/material.dart';
import 'package:todo_list/src/models/todo.dart';
import 'package:todo_list/src/services/abstract-todo-service.dart';

//* Todo provider
class TodoProvider<T extends Service> extends ChangeNotifier {

  TodoProvider(T service): _todoService = service.createInstance();   
  final T _todoService;
  final List<Todo> _todos = List<Todo>();

  //* Listado de Tareas
  Future<List<Todo>> getTodos({bool pulling = false}) async {
    if (pulling) {
      _todos.clear();
    }
    if (_todos.isNotEmpty){
      return _todos;
    }
    var todos = await _todoService.getTodos();
    _todos.addAll(todos);
    return _todos;
  }

  Todo getTodoByIndex(int index) {
    return _todos[index];
  }

  addTodo(Todo todo) async {
    await _todoService.addTodo(todo);
    var todos = await _todoService.getTodos();

    _todos..clear()..addAll(todos);
    notifyListeners();
  }

  deleteTodo(int index) async {
    await _todoService.deleteTodo(_todos[index].name);

    _todos.removeAt(index);
    notifyListeners();
  }

  updateTodo(int index, Todo todo) {
    _todoService.updateTodo(todo);
    _todos[index] = todo;
    notifyListeners();
  }

}