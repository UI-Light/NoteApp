import 'package:flutter/material.dart';
import 'package:note_app/data/database_service.dart';
import 'package:note_app/models/note.dart';

class EditNote extends StatefulWidget {
  final Note note;
  EditNote({required this.note});
  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  late TextEditingController titleController;
  late TextEditingController noteController;

  bool containsText = false;

  void editNote() async {
    DataBaseService dataBaseService = DataBaseService();
    await dataBaseService.updateNote(
      Note(
        title: titleController.text,
        body: noteController.text,
        date: DateTime.now(),
        id: widget.note.id,
      ),
    );
    Navigator.of(context).pop();
  }

  void deleteNote() async {
    DataBaseService dataBaseService = DataBaseService();
    await dataBaseService.deleteNote(widget.note.id);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    noteController = TextEditingController(text: widget.note.body);
    titleController.addListener(() {
      if (titleController.text.isEmpty) {
        setState(() {
          containsText = false;
        });
      } else {
        setState(() {
          containsText = true;
        });
      }
    });
    noteController.addListener(() {
      if (noteController.text.isEmpty) {
        setState(() {
          containsText = false;
        });
      } else {
        setState(() {
          containsText = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.green,
                          size: 30,
                        ),
                      ),
                      Text(
                        "Notes",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      if (containsText)
                        GestureDetector(
                          onTap: () {
                            editNote();
                          },
                          child: Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(21, 16.0, 8.0, 0.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          textCapitalization: TextCapitalization.sentences,
                          controller: titleController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 1,
                          decoration: InputDecoration(
                              hintText: "Title",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                        TextField(
                          textCapitalization: TextCapitalization.sentences,
                          controller: noteController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "Note Something Down",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            deleteNote();
          },
          child: Icon(
            Icons.delete,
          ),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
