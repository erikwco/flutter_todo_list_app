import 'package:flutter/material.dart';
import 'package:todo_list/src/providers/todo-provider.dart';
import 'package:todo_list/src/services/todo-service-firebase.dart';
// import 'package:todo_list/src/services/todo-service-sqflite.dart';
// import 'package:todo_list/src/services/todo-service.dart';
import 'package:todo_list/src/widgets/todo/list-todo-page.dart';
import 'package:provider/provider.dart';

//* Main App
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoProvider>.value(
          // value: TodoProvider(TodoServiceSQFLite()),
          // value: TodoProvider(TodoService()),
          value: TodoProvider(TodoServiceFirebase()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo list',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ListTodoPage(),
      ),
    );
  }
}
