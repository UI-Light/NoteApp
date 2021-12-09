import 'package:flutter/material.dart';
import 'package:note_app/notes_screen.dart';


class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('To-dos',
                style: TextStyle(
                  fontSize:18,
                  fontWeight: FontWeight.w600,
                ),),
                Icon(Icons.more_vert_outlined , color: Colors.green),
              ],
            ),
          ),
          SizedBox(height:20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid),
              ),
                hintText: 'Search to-dos',
                hintStyle: TextStyle(
                  fontSize: 17,
                ) ,
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.symmetric(vertical: 1)
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }
}
