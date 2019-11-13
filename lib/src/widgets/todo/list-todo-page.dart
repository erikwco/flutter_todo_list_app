import 'package:flutter/material.dart';
import 'package:todo_list/src/models/todo.dart';

class ListTodoPage extends StatefulWidget {
  @override
  _ListTodoPageState createState() => _ListTodoPageState();
}

class _ListTodoPageState extends State<ListTodoPage> {
  final _formKey = GlobalKey<FormState>();
  String name;
  String description;

  //* Listado temporal de todo
  List<Todo> todos = [
    Todo(name: 'Task1', description: 'Task 1 description'),
    Todo(name: 'Task2', description: 'Task 2 description'),
    Todo(name: 'Task3', description: 'Task 3 description'),
    Todo(name: 'Task4', description: 'Task 4 description'),
    Todo(name: 'Task5', description: 'Task 5 description'),
    Todo(name: 'Task6', description: 'Task 6 description'),
    Todo(name: 'Task7', description: 'Task 7 description'),
  ];

  //* Construye todo item
  Widget _buildTodoItem(Todo todo) {
    return ListTile(
      leading: Icon(Icons.check_box_outline_blank),
      title: Text(
        todo.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.none,
        ),
      ),
      subtitle: Text(todo.description),
    );
  }

  //* muestra dialogo para 
  Widget _buildDialog() {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.text_format),
                  hintText: 'Nombre de la tarea',
                  labelText: 'Nombre',
                ),
                onSaved: (String value) {
                  name = value;
                },
                validator: (String value) {
                  return value.isEmpty ? 'Ingrese una nombre' : null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.text_format),
                  hintText: 'Descripción',
                  labelText: 'Descripcion',
                ),
                onSaved: (String value) {
                  description = value;
                },
                validator: (String value) {
                  return value.isEmpty ? 'Ingrese una descripcion' : null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text("Crear"),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    setState(() {
                      todos.add(Todo(name: name, description: description));
                    });
                    Navigator.of(context).pop();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List App"),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildTodoItem(todos[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return _buildDialog();
              });
        },
      ),
    );
  }
}
