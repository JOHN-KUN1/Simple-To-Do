import 'package:flutter/material.dart';
import 'package:to_do/screens/new_todo.dart';

class AllTodo extends StatelessWidget {
  const AllTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 163, 132, 216),
      appBar: AppBar(
        title: const Text('Simple Todo',style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white
        ),),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 108, 69, 176),
      ),
      body: const Center(
        child: Text('your todo items are here'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const NewTodo(),));
      },child: const Icon(Icons.add),),
    );
  }

}