import 'package:flutter/material.dart';
import 'package:todo_list/src/widgets/todo/list-todo-page.dart';

//* Main App
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo list',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListTodoPage(),
    );
  }
}


