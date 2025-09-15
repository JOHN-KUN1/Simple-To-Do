import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:to_do/model/todo.dart';
import 'package:to_do/provider/todo_list.dart';
import 'package:to_do/screens/new_todo.dart';

class AllTodo extends ConsumerStatefulWidget {
  const AllTodo({super.key});

  @override
  ConsumerState<AllTodo> createState() => _AllTodoState();
}

class _AllTodoState extends ConsumerState<AllTodo> {
  bool isChecked = false;
  Future<List<Todo>>? _loadTodos;

  @override
  void initState() {
    _loadTodos = ref.read(allTodos.notifier).loadAllTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todoList = ref.watch(allTodos);
    Widget content = const Center(
      child: Text(
        'You do not have any todo\'s yet...',
        style: TextStyle(color: Colors.white),
      ),
    );

    if (todoList.isNotEmpty) {
      content = ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          Color checkboxSideColor = Colors.red;
          if (todoList[index].priority == TaskPriority.medium) {
            checkboxSideColor = Colors.amber;
          } else if (todoList[index].priority == TaskPriority.low) {
            checkboxSideColor = Colors.lightBlue;
          }
          return Dismissible(
            direction: DismissDirection.horizontal,
            key: ValueKey(todoList[index].id),
            onDismissed: (direction) async {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Todo Deleted..',
                    textAlign: TextAlign.center,
                  ),
                  duration: Duration(seconds: 2),
                ),
              );
              await ref.read(allTodos.notifier).deleteTodo(todoList[index].id!);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 12, right: 12),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color.fromARGB(255, 108, 69, 176),
                ),
                width: double.infinity,
                height: 80,
                child: Center(
                  child: CheckboxListTile(
                    side: BorderSide(width: 1, color: checkboxSideColor),
                    activeColor: Colors.white,
                    checkColor: const Color.fromARGB(255, 108, 69, 176),
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      todoList[index].title,
                      style: TextStyle(
                        decoration: todoList[index].isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                        decorationStyle: TextDecorationStyle.solid,
                        decorationColor: Colors.white,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    value: todoList[index].isCompleted,
                    onChanged: (value) async {
                      await ref
                          .read(allTodos.notifier)
                          .updateTodo(todoList[index], value!);
                      setState(() {
                        todoList[index].isCompleted = value;
                      });
                    },
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 163, 132, 216),
      appBar: AppBar(
        title: const Text(
          'Simple Todo',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 108, 69, 176),
      ),
      body: FutureBuilder(
        future: _loadTodos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.white,
                size: 70,
              ),
            );
          }
          if (snapshot.data != null && snapshot.data!.isEmpty) {
            return content;
          }
          return content;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewTodo(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
