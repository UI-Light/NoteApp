import 'package:note_app/data/database_service.dart';
import 'package:note_app/domain/models/note.dart';
import 'package:note_app/domain/repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  late DataBaseService dataBaseService;
  NoteRepositoryImpl() {
    dataBaseService = DataBaseService();
  }
  Future<List<Note>> fetchNotes() async {
    return await dataBaseService.fetchNotes();
  }

  Future<void> insertNote(String title, String body) async {
    await dataBaseService.insertNote(
      Note(
        title: title,
        body: body,
        date: DateTime.now(),
        id: DateTime.now().toIso8601String(),
      ),
    );
  }

  Future<void> editNote(
      {required String title, required String body, required String id}) async {
    await dataBaseService.updateNote(
      Note(
        title: title,
        body: body,
        date: DateTime.now(),
        id: id,
      ),
    );
  }

  Future<void> deleteNote({required String id}) async {
    await dataBaseService.deleteNote(id);
  }
}
