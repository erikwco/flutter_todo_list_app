import 'dart:async';

import 'package:todo_list/src/models/todo.dart';

//* Todo service
//* Local
class TodoService {
  final  List<Todo> todos = [
    Todo(name: 'Task1', description: 'Task 1 description'),
    Todo(name: 'Task2', description: 'Task 2 description'),
    Todo(name: 'Task3', description: 'Task 3 description'),
    Todo(name: 'Task4', description: 'Task 4 description'),
    Todo(name: 'Task5', description: 'Task 5 description'),
    Todo(name: 'Task6', description: 'Task 6 description'),
    Todo(name: 'Task7', description: 'Task 7 description'),
  ];


  Future<List<Todo>> getTodos()  {
    return Future.value(todos);
  }

  Todo getTodoByIndex(int index){
    return todos.elementAt(index);
  }

  Future<int> addTodo(Todo todo) {
    todos.add(todo);
    return Future.value(1);
  }

  Future<int> deleteTodo(int index){
    todos.removeAt(index);
    return Future.value(1);
  }

  Future<int> updateTodo(int index, Todo todo){
    todos[index].name = todo.name;
    todos[index].description = todo.description;
    todos[index].isComplete = todo.isComplete;
    return Future.value(1);
  }


}