import 'package:flutter/material.dart';
import 'package:todo_list/src/models/todo.dart';
import 'package:todo_list/src/services/abstract-todo-service.dart';
// import 'package:todo_list/src/services/todo-service-sqflite.dart';
import 'package:todo_list/src/services/todo-service.dart';

//* Todo provider
class TodoProvider<T extends Service> extends ChangeNotifier {

  TodoProvider(T service): _todoService = service.createInstance();   
  final T _todoService;
  // final TodoServiceSQFLite _todoServiceDb = TodoServiceSQFLite.instance;
  final List<Todo> _todos = List<Todo>();

  //* Listado de Tareas
  Future<List<Todo>> getTodos() async {
    if (_todos.isNotEmpty) {      
      return _todos;
    }
    // SQFlite
    // var todos = await _todoServiceDb.getTodos();
    // Local
    var todos = await _todoService.getTodos();
    _todos.addAll(todos);
    return _todos;
  }

  Todo getTodoByIndex(int index) {
    return _todos[index];
  }

  addTodo(Todo todo) async {
    // SQFlite
    // await _todoServiceDb.addTodo(todo);
    // var todos = await _todoServiceDb.getTodos();
    // Local
    await _todoService.addTodo(todo);
    var todos = await _todoService.getTodos();

    _todos..clear()..addAll(todos);
    notifyListeners();
  }

  deleteTodo(int index) async {
    // SQFlite
    // await _todoServiceDb.deleteTodo(_todos[index].name);
    // Local
    await _todoService.deleteTodo(index.toString());

    _todos.removeAt(index);
    notifyListeners();
  }

  updateTodo(int index, Todo todo) {
    // SQFLite
    // _todoServiceDb.updateTodo(todo);
    // Local
    _todoService.updateTodo(todo);
    _todos[index] = todo;
    notifyListeners();
  }

}