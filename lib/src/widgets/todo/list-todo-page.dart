import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/models/todo.dart';
import 'package:todo_list/src/providers/todo-provider.dart';
import 'package:todo_list/src/widgets/todo/detail-todo-page.dart';

class ListTodoPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  //todo: por simplicidad se utilizaran dos String no finales para evitar cambiar a TextControllers
  String name;
  String description;

  //* ********************************
  //* Todo Ui
  //* ********************************
  //* Construye item de cada tarea
  Widget _buildTodoItem(BuildContext context, Todo todo, int index) {
    var prov = Provider.of<TodoProvider>(context);
    return ListTile(
      leading: IconButton(
        icon: Icon(
            todo.isComplete ? Icons.check_box : Icons.check_box_outline_blank),
        onPressed: () {
          todo.isComplete = !todo.isComplete;
          prov.updateTodo(index, todo);
        },
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.delete_forever,
          color: Colors.redAccent,
        ),
        onPressed: () {
          prov.deleteTodo(index);
        },
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailTodoPage(
                  index: index,
                )));
      },
      title: Text(
        todo.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          decoration: todo.isComplete
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      subtitle: Text(todo.description),
    );
  }

  //* muestra dialogo para la creación de tarea
  Widget _buildDialog(BuildContext context) {
    var prov = Provider.of<TodoProvider>(context);
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
                    prov.addTodo(Todo(name: name, description: description));
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

  //* Build
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<TodoProvider>(context);
    // var todos = prov.getTodos();
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List App"),
      ),
      body: FutureBuilder(
        future: prov.getTodos(),
        builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var todos = snapshot.data;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildTodoItem(context, todos[index], index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return _buildDialog(context);
              });
        },
      ),
    );
  }
}
