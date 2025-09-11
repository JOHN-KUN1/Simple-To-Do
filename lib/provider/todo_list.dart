import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:to_do/model/todo.dart';

class TodoListNotifier extends StateNotifier<List<Todo>> {
    TodoListNotifier():super([]);

    void addTodo(Todo todo){
        state = [...state, todo];
    }

}

final allTodos = StateNotifierProvider<TodoListNotifier, List<Todo>>((ref){
    return TodoListNotifier();
});