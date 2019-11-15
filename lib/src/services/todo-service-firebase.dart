import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/src/models/todo.dart';
import 'package:todo_list/src/services/abstract-todo-service.dart';

class TodoServiceFirebase  extends Service {
  static final TodoServiceFirebase instance = TodoServiceFirebase._();
  factory TodoServiceFirebase() => instance;
  TodoServiceFirebase._();

  final Firestore _firestore = Firestore.instance;
  final List<Todo> _todos = List<Todo>();

  //* Agregar tarea
  //* Maneja ambas tareas actualización
  //* y creación de nuevas tareas
  @override
  Future<int> addTodo(Todo todo) async {
    // referencia de documento
    // var id = _firestore.collection("tasks").document(todo.uuid);
    var docRef = _firestore.collection("tasks").document(todo.uuid);
    todo.uuid = docRef.documentID;
    await _firestore.runTransaction((tx) async {
      // fresh copy
      DocumentSnapshot snapshot = await tx.get(docRef);
      if (snapshot.data != null) { // actualizacion
        tx.update(docRef, todo.toMap());
      } else { // creacion
        tx.set(docRef, todo.toMap());
      }
    });

    return Future.value(1);
  }

  @override
  Service createInstance() {
    return instance;
  }

  //* Elimina Tarea
  @override
  Future<int> deleteTodo(String key) async {
    // indice
    var index = _todos.indexWhere((item) => item.name == key);
    // Obteniendo referencia del cliente
    DocumentReference docRef = _firestore.collection("tasks").document(_todos[index].uuid);
    // Generando transacción
    await _firestore.runTransaction((transactionHandler) async {
      // eliminado registro del cliente
      transactionHandler.delete(docRef);
    });

    return Future.value(1);
  }

  @override
  Todo getTodoByIndex(int index) {
    return null;
  }

  @override
  Todo getTodoByKey(String key) {
    return null;
  }

  //* Obtiene las tareas de la base
  @override
  Future<List<Todo>> getTodos() async {
    try {
      _todos.clear();
      var stream = await _firestore.collection('tasks').getDocuments();
      stream.documents.forEach((doc){
         _todos.add(Todo.fromMap(doc.data));
      });

      return Future.value(_todos);

    } catch (e) {
      print(e.toString());
      return _todos;
    }
  }

  @override
  Future<int> updateTodo(Todo todo) async {
    return await addTodo(todo);
  }

}