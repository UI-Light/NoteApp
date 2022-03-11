import 'package:flutter/material.dart';
import 'package:note_app/models/todo.dart';
import 'package:note_app/utils/date_util.dart';

class TodoCard extends StatefulWidget {
  final Todo todo;
  const TodoCard({Key? key, required this.todo}) : super(key: key);

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: MediaQuery.of(context).size.height / 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  isTapped = !isTapped;
                });
              },
              icon: isTapped
                  ? Icon(Icons.check_circle)
                  : Icon(Icons.circle_outlined),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.todo.event,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  DateUtil.formatDate(widget.todo.date),
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
