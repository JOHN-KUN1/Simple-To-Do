import 'package:flutter/material.dart';
import 'package:to_do/model/todo.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({super.key});

  @override
  State<NewTodo> createState() {
    return _NewTodoState();
  }
}

class _NewTodoState extends State<NewTodo> {
  final todoController = TextEditingController();

  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 163, 132, 216),
      appBar: AppBar(
        title: const Text(
          'New To Do',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color.fromARGB(255, 108, 69, 176),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(label: Text('New Todo')),
                    autocorrect: true,
                    controller: todoController,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: DropdownMenu(
              onSelected: (value) {
                print('----------------------heyyy');
              },
              initialSelection: TaskPriority.low,
              dropdownMenuEntries: TaskPriority.values.map((p) {
                var icon = const Icon(
                  Icons.circle,
                  color: Colors.lightBlue,
                );
                if (p.name == 'medium') {
                  icon = const Icon(
                    Icons.circle,
                    color: Colors.amber,
                  );
                } else if (p.name == 'high') {
                  icon = const Icon(
                    Icons.circle,
                    color: Colors.red,
                  );
                }
                return DropdownMenuEntry(
                  trailingIcon: icon,
                  value: p,
                  label: p.name.toUpperCase(),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () {}, child: const Text('Clear')),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    backgroundColor: const Color.fromARGB(255, 163, 132, 216),
                  ),
                  child: const Text('Add Todo'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
