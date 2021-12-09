import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/create_note.dart';
import 'package:note_app/todoScreen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column (
            children: <Widget> [
              Container(
                margin: EdgeInsets.fromLTRB(10, 70, 0, 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Notes',
                  style: TextStyle(
                    fontSize:30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Search notes', 
                    fillColor: Colors.grey[300],
                    filled: true,
                    prefixIcon: Icon(Icons.search,),
                    ),
                  ),
                ),
              SizedBox(height: 70),
              Container(
                child: Center(
                  child: Icon(
                    Icons.note,
                    size: 50,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Center(
                child: Text('Click + to create new notes',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey[500],
                  ) ,
                ),
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNote()));
        },
        child: Icon(Icons.add,),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar:BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {  },
              icon: Icon(Icons.sticky_note_2_outlined),
              color: Colors.green,
            ),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Todo()));
              },
              icon: Icon(Icons.today_outlined),
              color: Colors.green,
            ),
           label: 'Todo',
          ),
        ],

      ),
    );
  }
}
