enum TaskPriority{
  low,
  medium,
  high
}

class Todo {
  Todo({required this.title, required this.priority, this.isCompleted = false});

  final String title;
  final TaskPriority priority;
  bool isCompleted;

}