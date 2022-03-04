import 'package:flutter/material.dart';

class TodoCard extends StatefulWidget {
  const TodoCard({Key? key}) : super(key: key);

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
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
            Icon(Icons.check_circle),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Remind bro uche to buy tapes',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'February 19, 2022 01:00 PM',
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
