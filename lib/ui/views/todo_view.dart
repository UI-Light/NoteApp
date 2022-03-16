import 'package:flutter/material.dart';

import 'package:note_app/models/todo.dart';
import 'package:note_app/ui/shared/search_bar.dart';
import 'package:note_app/ui/shared/todo_bottom_sheet.dart';
import 'package:note_app/ui/shared/todo_card.dart';
import 'package:note_app/data/database_service.dart';
import 'package:note_app/ui/shared/edit_bottom_sheet.dart';
import 'package:note_app/ui/views/delete_todos_view.dart';

class TodoView extends StatefulWidget {
  @override
  _TodoViewState createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  List<Todo> todos = [];
  List<Todo> unfilteredTodos = [];
  TextEditingController searchTodoController = TextEditingController();

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
    unfilteredTodos = todos = await dataBaseService.fetchTodos();

    setState(() {});
  }

  @override
  void initState() {
    fetchTodos();
    super.initState();
    searchTodoController.addListener(() {
      if (searchTodoController.text.isEmpty) {
        setState(() {
          fetchTodos();
        });
      } else {
        filterTodo(searchTodoController.text);
      }
    });
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
                SearchBar(
                    controller: searchTodoController,
                    hintText: 'Search to-dos'),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => GestureDetector(
                      onLongPress: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DeleteTodosView(
                            todos: todos,
                            index: index,
                          ),
                        ),
                      ),
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

  void filterTodo(String keyword) {
    final searchTodos = unfilteredTodos.where((todo) {
      final containsEvent =
          todo.event.toLowerCase().contains(keyword.toLowerCase());
      return containsEvent;
    }).toList();
    setState(() {
      todos = searchTodos;
    });
  }
}
