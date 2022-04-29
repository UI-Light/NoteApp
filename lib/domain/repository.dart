import 'package:note_app/domain/models/note.dart';
import 'package:note_app/domain/models/todo.dart';

abstract class NoteRepository {
  Future<List<Note>> fetchNotes();
  Future<void> insertNote(String title, String body);
  Future<void> editNote(
      {required String title, required String body, required String id});
  Future<void> deleteNote({required String id});
}

abstract class TodoRepository {
  Future<List<Todo>> fetchTodos();
  Future<void> saveEvent({required String event});
  Future<void> editTodo({required String event, required String id});
  Future<void> deleteTodo(String id);
}
