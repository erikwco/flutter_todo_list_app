import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/providers/todo-provider.dart';

class DetailTodoPage extends StatelessWidget {
  final int index;
  DetailTodoPage({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<TodoProvider>(context);
    var current = prov.getTodoByIndex(index);
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarea: ${current.name}"),
      ),
      body: Center(
        child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              current.description,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  decoration: current.isComplete
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Completada :") ,
                IconButton(
                  icon: Icon(current.isComplete ? Icons.check_box : Icons.check_box_outline_blank),
                  onPressed: () {
                    current.isComplete = !current.isComplete;
                    prov.updateTodo(index, current);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
