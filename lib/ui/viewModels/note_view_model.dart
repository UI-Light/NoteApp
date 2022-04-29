import 'package:flutter/material.dart';
import 'package:note_app/data/repository/notes_repository.dart';
import 'package:note_app/domain/models/note.dart';
import 'package:note_app/domain/note_domain.dart';

class NoteViewModel extends ChangeNotifier {
  NoteViewModel() {
    init();
  }

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

  //Depend on the domain relevant to the view model
  final noteDomain = NoteDomain(NoteRepositoryImpl());

  //Expose a getter that retrieves the required data from the domain
  ValueNotifier<List<Note>> get note => noteDomain.notes;

  void init() {
    noteDomain.notes.addListener(() {
      _notes = _unfilteredNotes = noteDomain.notes.value;
      notifyListeners();
    });
  }

  void fetchNotes() async {
    setLoading(true);
    await noteDomain.fetchNotes();
    setLoading(false);
  }

  void insertNote(String title, String body) {
    noteDomain.insertNote(title, body);
  }

  void editNote(
      {required String title, required String body, required String id}) {
    noteDomain.editNote(title: title, body: body, id: id);
  }

  void deleteNote({required String id}) {
    noteDomain.deleteNote(id: id);
  }
}
