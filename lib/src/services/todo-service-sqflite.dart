import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_list/src/models/todo.dart';
import 'package:todo_list/src/services/abstract-todo-service.dart';

//* **********************************************************
//* Servicio para conectarse con SqFlite
//* Esta diseñado pensando solo en una tabla en especifico
//* aunque facilmente puede hacerse generica
//* **********************************************************
class TodoServiceSQFLite  extends Service{

  //* Singleton instance - para no permitir mas de una sola instancia
  static final TodoServiceSQFLite instance = TodoServiceSQFLite._();
  factory TodoServiceSQFLite() => instance ;
  TodoServiceSQFLite._() ;

  @override
  Service createInstance() {
    return instance;
  }
  //* Instancia de la base
  Database _database;
  final String _table = 'tasks';
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initialize();
    //! La idea es que solo se ejecute una vez
    //! y por ende crear solo una vez la data
    await _seedDatabase();
    return _database;
  }


  //* database initialize
  Future<Database> initialize() async {
    return openDatabase(
      join(await getDatabasesPath(), 'task_database_v2.db'),
      onCreate: (db, version) async {
        return await db.execute('CREATE TABLE $_table(name TEXT PRIMARY KEY, description TEXT, isComplete INTEGER)');
      },
      version: 1
    );
  }

  //* seedDatabase
  _seedDatabase() async {
    final Database db = await this.database;
    var data = await getTodos();
    //! No recomendado se ha utilizado solo con propositos 
    //! educativos y de prueba la data debe de fluir
    //! desde el UI
    if (data.length ==0) {
      List<Todo> todos = List<Todo>.generate(10, (index) => Todo(name: 'Task $index', description: 'Description task $index') );
      todos.forEach((todo) async {
        await db.insert(_table, todo.toMap(), conflictAlgorithm: ConflictAlgorithm.ignore);
      });
    } 
  }

  //* List of Tareas
  @override
  Future<List<Todo>> getTodos() async {
    final Database db = await this.database;
    final List<Map<String, dynamic>> tasks = await db.query(_table);
    return List<Todo>.generate(tasks.length, (index) {
      return Todo.fromMap(tasks[index]);
    });
  }

  //* Agregando tarea
  @override
  Future<int> addTodo(Todo todo) async {
    final Database db = await this.database;
    return await db.insert(_table, todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Eliminando Tarea
  @override
  Future<int> deleteTodo(String key) async {
    final Database db = await this.database;
    return await db.delete(_table, where: 'name = ?', whereArgs: [key]);
  }

  // Actualizando Tarea
  @override
  Future<int> updateTodo(Todo todo) async {
    final Database db = await this.database;
    return await db.update(_table, todo.toMap(), where: 'name = ?', whereArgs: [todo.name]);
  }

  @override
  Todo getTodoByIndex(int index) {
    return null;
  }

  @override
  Todo getTodoByKey(String key) {
    return null;
  }

}