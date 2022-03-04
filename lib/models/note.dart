class Note {
  final String title;
  final String body;
  final DateTime date;
  Note({
    required this.title,
    required this.body,
    required this.date,
  });
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json["title"],
      body: json["body"],
      date: DateTime.parse(json["date"]),
    );
  }
}
