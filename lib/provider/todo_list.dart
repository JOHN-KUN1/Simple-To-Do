import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:to_do/model/todo.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), 'todo_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE newtodos (id TEXT PRIMARY KEY,title TEXT, priority TEXT, isCompleted INTEGER )',
      );
    },
    version: 2,
  );
}

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([]);

  void addTodo(Todo todo) async {
    state = [...state, todo];
    final database = await getDatabase();

    final todoMap = {
      'id':todo.id,
      'title' : todo.title,
      'priority' : todo.priority.name,
      'isCompleted' : todo.isCompleted == true ? 1 : 0
    };

    await database.insert('newtodos',todoMap,conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Todo>> loadAllTodos() async {
    List<Todo> loadedTodos = [];
    final database = await getDatabase();
    final List<Map<String, Object?>> allTodos = await database.query('newtodos');
    for (final i in allTodos) {
      var priority = TaskPriority.low;
      if (i['priority'] == TaskPriority.medium.name) {
        priority = TaskPriority.medium;
      } else if (i['priority'] == TaskPriority.high.name) {
        priority = TaskPriority.high;
      }
      loadedTodos.add(
        Todo(
          id: i['id'] as String,
          title: i['title'] as String,
          priority: priority,
          isCompleted: i['isCompleted'] as int == 1 ? true : false,
        ),
      );
    }
    state = loadedTodos;

    return loadedTodos;
  }

  Future<void> updateTodo(Todo todo, bool value) async {
    final database = await getDatabase();

    final todoMap = {
      'id' : todo.id,
      'title' : todo.title,
      'priority' : todo.priority.name,
      'isCompleted' : value == true ? 1 : 0
    };

    database.update('newtodos', todoMap,where: 'id = ?', whereArgs: [todo.id]);
  }
}

final allTodos = StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier();
});
