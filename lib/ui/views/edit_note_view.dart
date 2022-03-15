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
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: Text(
            "Notes",
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.green,
              size: 30,
            ),
          ),
          actions: [
            if (containsText)
              GestureDetector(
                onTap: () {
                  editNote();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                ),
              ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(21, 16.0, 21.0, 0.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
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
