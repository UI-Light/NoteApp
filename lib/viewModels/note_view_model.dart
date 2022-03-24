import 'package:flutter/material.dart';
import 'package:note_app/data/database_service.dart';
import 'package:note_app/models/note.dart';

class NoteViewModel extends ChangeNotifier {
  List<Note> _notes = [];
  List<Note> _unfilteredNotes = [];
  bool _isLoading = false;

  List<Note> get notes => _notes.reversed.toList();
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void assignNotes() {
    _notes = _unfilteredNotes;
    notifyListeners();
  }

  void fetchNotes() async {
    setLoading(true);
    DataBaseService dataBaseService = DataBaseService();
    _unfilteredNotes = _notes = await dataBaseService.fetchNotes();
    setLoading(false);
  }

  void insertNote(String title, String body) async {
    DataBaseService dataBaseService = DataBaseService();
    await dataBaseService.insertNote(
      Note(
        title: title,
        body: body,
        date: DateTime.now(),
        id: DateTime.now().toIso8601String(),
      ),
    );
    fetchNotes();
  }

  void editNote(
      {required String title, required String body, required String id}) async {
    DataBaseService dataBaseService = DataBaseService();
    await dataBaseService.updateNote(
      Note(
        title: title,
        body: body,
        date: DateTime.now(),
        id: id,
      ),
    );

    fetchNotes();
  }

  void deleteNote({required String id}) async {
    DataBaseService dataBaseService = DataBaseService();
    await dataBaseService.deleteNote(id);
    fetchNotes();
  }

  void filterNotes(String keyword) {
    final searchNotes = _unfilteredNotes.where((note) {
      final containsTitle =
          note.title.toLowerCase().contains(keyword.toLowerCase());
      final containsBody =
          note.body.toLowerCase().contains(keyword.toLowerCase());
      return containsTitle || containsBody;
    }).toList();
    _notes = searchNotes;
    notifyListeners();
  }
}
