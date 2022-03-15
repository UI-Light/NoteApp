import 'package:flutter/material.dart';
import 'package:note_app/data/database_service.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/ui/shared/note_card.dart';
import 'package:note_app/ui/shared/search_bar.dart';
import 'package:note_app/ui/views/edit_note_view.dart';
import 'package:note_app/ui/views/new_note_view.dart';

class NoteView extends StatefulWidget {
  @override
  _NoteViewState createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  List<Note> notes = [];
  List<Note> unfilteredNotes = [];

  TextEditingController searchNoteController = TextEditingController();

  void fetchNotes() async {
    DataBaseService dataBaseService = DataBaseService();
    unfilteredNotes = notes = await dataBaseService.fetchNotes();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    searchNoteController.addListener(() {
      if (searchNoteController.text.isEmpty) {
        setState(() {
          notes = unfilteredNotes;
        });
      } else {
        filterNotes(searchNoteController.text);
      }
    });
    Future.microtask(() => fetchNotes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 70, 20, 0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Notes',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SearchBar(
                    controller: searchNoteController, hintText: 'Search Notes'),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditNote(
                              note: notes[index],
                            ),
                          ),
                        );
                        fetchNotes();
                      },
                      child: NoteCard(
                        note: notes[index],
                      ),
                    ),
                    itemCount: notes.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateNote()));
          fetchNotes();
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  void filterNotes(String keyword) {
    final searchNotes = unfilteredNotes.where((note) {
      final containsTitle =
          note.title.toLowerCase().contains(keyword.toLowerCase());
      final containsBody =
          note.body.toLowerCase().contains(keyword.toLowerCase());
      return containsTitle || containsBody;
    }).toList();
    setState(() {
      notes = searchNotes;
    });
  }
}
