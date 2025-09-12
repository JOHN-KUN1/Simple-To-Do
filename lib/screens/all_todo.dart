import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/provider/todo_list.dart';
import 'package:to_do/screens/new_todo.dart';

class AllTodo extends ConsumerStatefulWidget {
  const AllTodo({super.key});

  @override
  ConsumerState<AllTodo> createState() => _AllTodoState();
}

class _AllTodoState extends ConsumerState<AllTodo> {
  bool isChecked = false;

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
          return Padding(
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
                  activeColor: Colors.white,
                  checkColor: const Color.fromARGB(255, 108, 69, 176),
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    todoList[index].title,
                    style: TextStyle(
                      decoration: todoList[index].isCompleted ? TextDecoration.lineThrough : null,
                      decorationStyle: TextDecorationStyle.solid,
                      decorationColor: Colors.white,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  value: todoList[index].isCompleted,
                  onChanged: (value) {
                    setState(() {
                      todoList[index].isCompleted = value!;
                    });
                  },
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
      body: content,
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
