import 'package:note_app/domain/models/note.dart';
import 'package:note_app/domain/models/todo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const noteTable = 'Notes';
const todoTable = 'Todo';

class DataBaseService {
  Future<Database> createDatabase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'noteapp.db');

    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
        'CREATE TABLE IF NOT EXISTS $noteTable (title TEXT, body TEXT, date TEXT, id TEXT PRIMARY KEY)',
      );
      await db.execute(
        'CREATE TABLE IF NOT EXISTS $todoTable (event TEXT, date TEXT, id TEXT PRIMARY KEY)',
      );
    });
    return database;
  }
  //Now to perform CRUD operations on NoteTable

  Future<void> insertNote(Note note) async {
    Database database = await createDatabase();
    await database.insert(noteTable, {
      "title": note.title,
      "body": note.body,
      "date": note.date.toIso8601String(),
      "id": note.id,
    });
  }

  Future<List<Note>> fetchNotes() async {
    Database database = await createDatabase();
    final notes = await database.query(noteTable);
    List<Note> convertedNotes = [];
    for (var oneNote in notes) {
      final convertedNote = Note.fromJson(oneNote);
      convertedNotes.add(convertedNote);
    }
    return convertedNotes;
  }

  Future<void> updateNote(Note note) async {
    Database database = await createDatabase();
    await database.update(noteTable, {
      "title": note.title,
      "body": note.body,
      "date": note.date.toIso8601String(),
      "id": note.id,
    });
  }

  Future<void> deleteNote(String id) async {
    Database database = await createDatabase();
    await database.delete(noteTable, where: "id = ?", whereArgs: [id]);
  }

  //CRUD operations on TodoTable
  Future<void> insertTodo(Todo todo) async {
    Database database = await createDatabase();
    await database.insert(todoTable, {
      "event": todo.event,
      "date": todo.date.toIso8601String(),
      "id": todo.id,
    });
  }

  Future<List<Todo>> fetchTodos() async {
    Database database = await createDatabase();
    final todos = await database.query(todoTable);

    List<Todo> convertedTodos = [];
    for (var oneTodo in todos) {
      final convertedTodo = Todo.fromJson(oneTodo);
      convertedTodos.add(convertedTodo);
    }
    return convertedTodos.reversed.toList();
  }

  Future<void> updateTodo(Todo todo) async {
    Database database = await createDatabase();
    await database.update(todoTable, {
      "event": todo.event,
      "date": todo.date.toIso8601String(),
      "id": todo.id,
    });
  }

  Future<void> deleteTodo(String id) async {
    Database database = await createDatabase();
    await database.delete(todoTable, where: "id = ?", whereArgs: [id]);
  }
}
