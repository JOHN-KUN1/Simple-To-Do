import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/screens/all_todo.dart';

void main(){
  runApp(const ProviderScope(
    child: MaterialApp(
      home: AllTodo()
    ),
  ));
}