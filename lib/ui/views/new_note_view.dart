import 'package:flutter/material.dart';
import 'package:note_app/ui/viewModels/note_view_model.dart';
import 'package:provider/provider.dart';
import 'package:note_app/utils/size_util.dart';

class CreateNote extends StatefulWidget {
  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  bool containsText = false;

  @override
  void initState() {
    super.initState();
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
      body: SafeArea(
        child: Container(
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
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    if (containsText)
                      GestureDetector(
                        onTap: () {
                          context.read<NoteViewModel>().insertNote(
                              titleController.text, noteController.text);
                          Navigator.of(context).pop();
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
                child: Padding(
                  padding: EdgeInsets.fromLTRB(21.w, 16.h, 8.w, 0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: titleController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 1,
                        decoration: InputDecoration(
                            hintText: 'Title',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      Expanded(
                        child: TextField(
                          textCapitalization: TextCapitalization.sentences,
                          controller: noteController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Note something down',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 20.sp,
                            ),
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
    );
  }
}
