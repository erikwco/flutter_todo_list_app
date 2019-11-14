//* Todo class
//* Por simplicidad del API 
//* que se esta construyendo
//* no se utilizan campos
//* Finales 
class Todo {
  String name;
  String description;
  bool isComplete;

  Todo({
    this.name, 
    this.description,
    this.isComplete=false
  });

  Map<String, dynamic> toMap() => {
    'name': this.name,
    'description': this.description,
    'isComplete': (this.isComplete) ? 1 : 0
  };

  factory Todo.fromMap(Map<String ,dynamic> data) {
    return Todo(name: data['name'], description: data['description'], isComplete: (data['isComplete'] == '1' ? true : false));
  }

}