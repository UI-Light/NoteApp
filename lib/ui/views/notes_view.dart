import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/ui/shared/note_card.dart';
import 'package:note_app/ui/views/new_note_view.dart';

class NoteView extends StatefulWidget {
  @override
  _NoteViewState createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
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
                Container(
                  height: 40,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search notes',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                      child: ListView(
                    children: [
                      NoteCard(
                        note: Note(
                          title: 'Shopping List',
                          body: 'Yeast',
                          date: DateTime.now(),
                        ),
                      ),
                      NoteCard(
                        note: Note(
                          title: 'Books to read',
                          body: 'Divergent',
                          date: DateTime.now(),
                        ),
                      ),
                      NoteCard(
                        note: Note(
                          title: 'Log notes',
                          body: 'yada yada yada',
                          date: DateTime.now(),
                        ),
                      ),
                      NoteCard(
                        note: Note(
                          title: 'Log notes',
                          body: 'yada yada yada',
                          date: DateTime.now(),
                        ),
                      ),
                      NoteCard(
                        note: Note(
                          title: 'Log notes',
                          body: 'yada yada yada',
                          date: DateTime.now(),
                        ),
                      ),
                      NoteCard(
                        note: Note(
                          title: 'Log notes',
                          body: 'yada yada yada',
                          date: DateTime.now(),
                        ),
                      ),
                    ],
                  )),
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
               
// Center(
//                       child: Icon(
//                         Icons.note,
//                         size: 50,
//                         color: Colors.grey[700],
//                       ),
//                     ),
// SizedBox(height: 40),
//                 Center(
//                   child: Text(
//                     'Click + to create new notes',
//                     style: TextStyle(
//                       fontSize: 10.0,
//                       color: Colors.grey[500],
//                     ),
//                   ),
//                 ),