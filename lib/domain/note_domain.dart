import 'package:flutter/material.dart';
import 'package:note_app/domain/models/note.dart';
import 'package:note_app/domain/repository.dart';

class NoteDomain {
  late NoteRepository noteRepository;
  NoteDomain(this.noteRepository);

  ValueNotifier<List<Note>> _notes = ValueNotifier([]);
  ValueNotifier<List<Note>> get notes => _notes;

  Future<void> fetchNotes() async {
    _notes.value = await noteRepository.fetchNotes();
  }

  void insertNote(String title, String body) async {
    await noteRepository.insertNote(title, body);
    fetchNotes();
  }

  void editNote(
      {required String title, required String body, required String id}) async {
    await noteRepository.editNote(title: title, body: body, id: id);
    fetchNotes();
  }

  void deleteNote({required String id}) async {
    await noteRepository.deleteNote(id: id);
    fetchNotes();
  }
}
