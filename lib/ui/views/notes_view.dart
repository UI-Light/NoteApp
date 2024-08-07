import 'package:flutter/material.dart';
import 'package:note_app/domain/models/note.dart';
import 'package:note_app/ui/routes/routes.dart';
import 'package:note_app/ui/shared/note_card.dart';
import 'package:note_app/ui/shared/search_box.dart';
import 'package:note_app/ui/viewModels/note_view_model.dart';
import 'package:provider/provider.dart';
import 'package:note_app/utils/size_util.dart';

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
    final isLoading = context.select<NoteViewModel, bool>(
        (noteViewModel) => noteViewModel.isLoading);
    final notes = context.select<NoteViewModel, List<Note>>(
        (noteViewModel) => noteViewModel.notes);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20.w,
              70.h,
              20.w,
              0,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Notes',
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                SearchBox(
                    controller: searchNoteController, hintText: 'Search Notes'),
                SizedBox(height: 20.h),
                Expanded(
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            //bool ? true:false
                            valueColor: AlwaysStoppedAnimation(Colors.green),
                            backgroundColor: Colors.grey,
                          ),
                        )
                      : !isLoading &&
                              notes
                                  .isEmpty //context.watch<NoteViewModel>().notes.isEmpty
                          ? Center(child: Text("No Note"))
                          : ListView.builder(
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      Routes.editNoteRoute,
                                      arguments: notes[index]);
                                  //  Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (context) => EditNote(
                                  //       note: notes[index],
                                  //     ),
                                  //   ),
                                  // );
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
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.newNoteRoute);
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => CreateNote()));
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
