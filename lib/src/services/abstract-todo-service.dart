import 'package:todo_list/src/models/todo.dart';

abstract class Service {
  Service createInstance();
  Future<List<Todo>> getTodos() ;
  Future<int> addTodo(Todo todo);
  Future<int> deleteTodo(String key);
  Future<int> updateTodo(Todo todo);
  Todo getTodoByIndex(int index);
  Todo getTodoByKey(String key);
}