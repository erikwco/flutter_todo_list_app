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

}