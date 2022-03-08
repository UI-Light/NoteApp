import "package:flutter/material.dart";
import 'package:note_app/data/database_service.dart';
import 'package:note_app/models/todo.dart';

class TodoBottomSheet extends StatefulWidget {
  const TodoBottomSheet({Key? key}) : super(key: key);

  @override
  State<TodoBottomSheet> createState() => _TodoBottomSheetState();
}

class _TodoBottomSheetState extends State<TodoBottomSheet> {
  TextEditingController addEventController = TextEditingController();
  bool containsText = false;

  void saveEvent() async {
    DataBaseService dataBaseService = DataBaseService();
    await dataBaseService.insertTodo(Todo(
      event: addEventController.text,
      date: DateTime.now(),
      id: DateTime.now().toIso8601String(),
    ));
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    addEventController.addListener(() {
      if (addEventController.text.isEmpty) {
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
    return Wrap(
      children: [
        Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 5),
          height: 40,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: TextField(
            controller: addEventController,
            decoration: InputDecoration(
              hintText: 'Add a to-do item',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
              border: InputBorder.none,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.alarm,
                      color: Colors.grey,
                      size: 20,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Set alerts',
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                saveEvent();
              },
              child: Text(
                'SAVE',
                style: TextStyle(
                    color: containsText ? Colors.green : Colors.grey,
                    fontSize: 14),
              ),
            ),
          ],
        )
      ],
    );
  }
}
