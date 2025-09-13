import 'package:uuid/uuid.dart';

enum TaskPriority{
  low,
  medium,
  high
}

final uuid = const Uuid();

class Todo {
  Todo({String? id,required this.title, required this.priority, this.isCompleted = false}) : id = id ?? uuid.v4();

  final String title;
  final TaskPriority priority;
  bool isCompleted;
  String? id;

}

