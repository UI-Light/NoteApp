import 'package:flutter/material.dart';
import 'package:note_app/ui/shared/note_card.dart';
import 'package:note_app/ui/shared/search_bar.dart';
import 'package:note_app/ui/views/edit_note_view.dart';
import 'package:note_app/ui/views/new_note_view.dart';
import 'package:note_app/viewModels/note_view_model.dart';
import 'package:provider/provider.dart';

class NoteView extends StatefulWidget {
  @override
  _NoteViewState createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  TextEditingController searchNoteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchNoteController.addListener(() {
      if (searchNoteController.text.isEmpty) {
        context.read<NoteViewModel>().assignNotes();
      } else {
        context.read<NoteViewModel>().filterNotes(searchNoteController.text);
      }
    });

    Future.microtask(() => context.read<NoteViewModel>().fetchNotes());
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
                  child: context.watch<NoteViewModel>().isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.green),
                            backgroundColor: Colors.grey,
                          ),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EditNote(
                                    note: context
                                        .watch<NoteViewModel>()
                                        .notes[index],
                                  ),
                                ),
                              );
                              context.read<NoteViewModel>().fetchNotes();
                            },
                            child: NoteCard(
                              note: context.watch<NoteViewModel>().notes[index],
                            ),
                          ),
                          itemCount:
                              context.watch<NoteViewModel>().notes.length,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateNote()));
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
