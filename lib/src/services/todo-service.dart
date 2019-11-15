import 'dart:async';

import 'package:todo_list/src/models/todo.dart';
import 'package:todo_list/src/services/abstract-todo-service.dart';

//* Todo service
//* Local
class TodoService  extends Service{

  //* Singleton instance - para no permitir mas de una sola instancia
  static final TodoService instance = TodoService._();
  factory TodoService() => instance;
  TodoService._() ;

  @override
  Service createInstance() {
    return instance;
  }

  final  List<Todo> todos = [
    Todo(name: 'Task1', description: 'Task 1 description'),
    Todo(name: 'Task2', description: 'Task 2 description'),
    Todo(name: 'Task3', description: 'Task 3 description'),
    Todo(name: 'Task4', description: 'Task 4 description'),
    Todo(name: 'Task5', description: 'Task 5 description'),
    Todo(name: 'Task6', description: 'Task 6 description'),
    Todo(name: 'Task7', description: 'Task 7 description'),
  ];


  @override
  Future<List<Todo>> getTodos()  {
    return Future.value(todos);
  }

  @override
  Todo getTodoByIndex(int index){
    return todos.elementAt(index);
  }

  @override
  Future<int> addTodo(Todo todo) {
    todos.add(todo);
    return Future.value(1);
  }

  @override
  Future<int> deleteTodo(String key){
    var index = todos.indexWhere((item) => item.name == key);
    todos.removeAt(index);
    return Future.value(1);
  }

  @override
  Future<int> updateTodo(Todo todo){
    var index = todos.indexWhere((item) => item.name == todo.name);
    todos[index].name = todo.name;
    todos[index].description = todo.description;
    todos[index].isComplete = todo.isComplete;
    return Future.value(1);
  }

  @override
  Todo getTodoByKey(String key) {
    return null;
  }


}