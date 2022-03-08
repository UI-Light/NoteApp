class Todo {
  final String event;
  final DateTime date;
  final String id;

  Todo({required this.event, required this.date, required this.id});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      event: json["event"] ?? "",
      date: DateTime.parse(json["date"]),
      id: json["id"] ?? "",
    );
  }
}
