import 'package:flutter/material.dart';
import 'package:note_app/utils/size_util.dart';
import 'package:note_app/domain/models/note.dart';
import 'package:note_app/ui/viewModels/note_view_model.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "Notes",
          style: TextStyle(
            color: Colors.black,
            fontSize: 17.sp,
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
                context.read<NoteViewModel>().editNote(
                    title: titleController.text,
                    body: noteController.text,
                    id: widget.note.id);
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: EdgeInsets.only(right: 10.w),
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
          padding: EdgeInsets.fromLTRB(21.w, 16.h, 21.w, 0.0),
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
                      fontSize: 25.sp,
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
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<NoteViewModel>().deleteNote(id: widget.note.id);
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.delete,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
