import 'package:sqflite/sqflite.dart';
import 'database.dart';
import 'package:task_organizer_persistencia/components/task.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$_name TEXT, '
      '$_image TEXT, '
      '$_difficulty INTEGER)';

  static const String _tableName = 'taskTable';
  static const String _name = 'name';
  static const String _image = 'image';
  static const String _difficulty = 'difficulty';

  save(Task tarefa) async {
    final Database bancoDeDados = await getDatabase();
    var itemExists = await find(tarefa.nome);

    if (itemExists.isEmpty) {
      Map<String, dynamic> taskMap = _toMap(tarefa);
      return bancoDeDados.insert(_tableName, taskMap);
    } else {
      return bancoDeDados.update(_tableName, _toMap(tarefa),
          where: '$_name = ?', whereArgs: [tarefa.nome]);
    }
  }

  Map<String, dynamic> _toMap(Task task) {
    final Map<String, dynamic> mapaDeTarefas = Map();
    mapaDeTarefas[_name] = task.nome;
    mapaDeTarefas[_image] = task.foto;
    mapaDeTarefas[_difficulty] = task.dificuldade;
    return mapaDeTarefas;
  }

  Future<List<Task>> findAll() async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tableName);
    List<Task> tasks = toList(result);
    return tasks;
  }

  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    final List<Task> tasks = [];
    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Task task = Task(
        linha[_name],
        linha[_image],
        linha[_difficulty],
      );
      tasks.add(task);
    }
    return tasks;
  }

  Future<List<Task>> find(String nomeDaTarefa) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(
      _tableName,
      where: '$_name = ?',
      whereArgs: [nomeDaTarefa],
    );
    List<Task> tasks = toList(result);
    return tasks;
  }

  delete(String nomeDaTarefa) async {
    final Database db = await getDatabase();
    return db
        .delete(_tableName, where: '$_name = ?', whereArgs: [nomeDaTarefa]);
  }
}
