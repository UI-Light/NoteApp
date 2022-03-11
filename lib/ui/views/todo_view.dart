import 'package:flutter/material.dart';
import 'package:note_app/models/todo.dart';
import 'package:note_app/ui/shared/todo_bottom_sheet.dart';
import 'package:note_app/ui/shared/todo_card.dart';
import 'package:note_app/data/database_service.dart';
import 'package:note_app/ui/shared/edit_bottom_sheet.dart';

class TodoView extends StatefulWidget {
  @override
  _TodoViewState createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  List<Todo> todos = [];

  void todoBottomSheet(context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return TodoBottomSheet();
        });
  }

  void fetchTodos() async {
    DataBaseService dataBaseService = DataBaseService();
    todos = await dataBaseService.fetchTodos();

    setState(() {});
  }

  @override
  void initState() {
    fetchTodos();
    super.initState();
  }

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
                  child: ListView.builder(
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () async {
                        await showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return EditBottomSheet(
                                todo: todos[index],
                              );
                            });
                        fetchTodos();
                      },
                      child: TodoCard(
                        todo: todos[index],
                      ),
                    ),
                    itemCount: todos.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          todoBottomSheet(context);
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
