import "package:flutter/material.dart";
import 'package:note_app/viewModels/todo_view_model.dart';
import 'package:provider/provider.dart';

class TodoBottomSheet extends StatefulWidget {
  const TodoBottomSheet({Key? key}) : super(key: key);

  @override
  State<TodoBottomSheet> createState() => _TodoBottomSheetState();
}

class _TodoBottomSheetState extends State<TodoBottomSheet> {
  TextEditingController addEventController = TextEditingController();
  bool containsText = false;

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
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 5),
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
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context
                            .read<TodoViewModel>()
                            .saveEvent(event: addEventController.text);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'SAVE',
                        style: TextStyle(
                            color: containsText ? Colors.green : Colors.grey,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          ),
        ],
      ),
    );
  }
}
