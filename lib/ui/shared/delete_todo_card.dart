import 'package:flutter/material.dart';
import 'package:note_app/models/todo.dart';
import 'package:note_app/utils/date_util.dart';

class DeleteTodoCard extends StatelessWidget {
  final Todo todo;
  final bool isChecked;
  final VoidCallback onChanged;

  const DeleteTodoCard(
      {Key? key,
      required this.todo,
      required this.isChecked,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.event,
                    maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    DateUtil.formatDate(todo.date),
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  )
                ],
              ),
            ),
            SizedBox(width: 20),
            Checkbox(
                value: isChecked,
                activeColor: Colors.green,
                checkColor: Colors.white,
                onChanged: (value) {
                  onChanged();
                }),
          ],
        ),
      ),
    );
  }
}