class Note {
  final String title;
  final String body;
  final DateTime date;
  final String id;
  Note({
    required this.title,
    required this.body,
    required this.date,
    required this.id,
  });
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json["title"],
      body: json["body"],
      date: DateTime.parse(json["date"]),
      id: json["id"],
    );
  }
}
