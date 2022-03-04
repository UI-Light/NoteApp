import 'package:flutter/material.dart';
import 'package:note_app/ui/shared/todo_card.dart';
import 'package:note_app/ui/views/new_todo_view.dart';

class TodoView extends StatefulWidget {
  @override
  _TodoViewState createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 70, 20, 0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'To-dos',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 40,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search to-dos',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    child: ListView(
                      children: [
                        TodoCard(),
                        TodoCard(),
                        TodoCard(),
                        TodoCard(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateTodo()));
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
