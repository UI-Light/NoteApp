import 'package:note_app/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const noteTable = 'Notes';

class DataBaseService {
  Future<Database> createNoteTable() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'noteapp.db');

    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE IF NOT EXISTS $noteTable (title TEXT, body TEXT, date TEXT PRIMARY KEY)');
    });
    return database;
  }

  Future<void> insertNote(Note note) async {
    Database database = await createNoteTable();
    await database.insert(noteTable, {
      "title": note.title,
      "body": note.body,
      "date": note.date.toIso8601String()
    });
  }

  Future<List<Note>> fetchNotes() async {
    Database database = await createNoteTable();
    final notes = await database.query(noteTable);
    List<Note> convertedNotes = [];
    for (var oneNote in notes) {
      final convertedNote = Note.fromJson(oneNote);
      convertedNotes.add(convertedNote);
    }
    return convertedNotes;
  }

  Future<void> updateNote(Note note) async {
    Database database = await createNoteTable();
    await database.update(noteTable, {
      "title": note.title,
      "body": note.body,
      "date": note.date.toIso8601String(),
    });
  }

  Future<void> deleteNote(Note note) async {
    Database database = await createNoteTable();
    await database.delete(noteTable,
        where: "date", whereArgs: [note.date.toIso8601String()]);
  }
}
