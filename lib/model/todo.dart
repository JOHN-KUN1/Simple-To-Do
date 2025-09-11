enum TaskPriority{
  low,
  medium,
  high
}

class Todo {
  const Todo({required this.title, required this.priority});

  final String title;
  final TaskPriority priority;

}