//* Todo class
//* Por simplicidad del API
//* que se esta construyendo
//* no se utilizan campos
//* Finales
import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String uuid;
  String name;
  String description;
  bool isComplete;

  Todo({this.uuid, this.name, this.description, this.isComplete = false});

  Map<String, dynamic> toMap() => {
        'uuid': this.uuid,
        'name': this.name,
        'description': this.description,
        'isComplete': (this.isComplete) ? 1 : 0
      };

  factory Todo.fromMap(Map<String, dynamic> data) {
    return Todo(
      uuid: data['uuid'],
      name: data['name'],
      description: data['description'],
      isComplete: (data['isComplete'] == '1' ? true : false),
    );
  }

  factory Todo.fromSnapshot(DocumentSnapshot doc) {
    var data = doc.data ?? {};
    return Todo.fromMap(data);
  }
}
