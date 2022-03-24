import 'package:flutter/material.dart';
import 'package:note_app/ui/shared/search_bar.dart';
import 'package:note_app/ui/shared/todo_bottom_sheet.dart';
import 'package:note_app/ui/shared/todo_card.dart';
import 'package:note_app/ui/shared/edit_bottom_sheet.dart';
import 'package:note_app/ui/views/delete_todos_view.dart';
import 'package:note_app/viewModels/todo_view_model.dart';
import 'package:provider/provider.dart';

class TodoView extends StatefulWidget {
  @override
  _TodoViewState createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  TextEditingController searchTodoController = TextEditingController();

  void todoBottomSheet(context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return TodoBottomSheet();
        });
  }

  @override
  void initState() {
    context.read<TodoViewModel>().fetchTodos();
    super.initState();
    searchTodoController.addListener(() {
      if (searchTodoController.text.isEmpty) {
        context.read<TodoViewModel>().fetchTodos();
      } else {
        context.read<TodoViewModel>().filterTodo(searchTodoController.text);
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
                            todos: context.watch<TodoViewModel>().todos,
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
                                todo:
                                    context.watch<TodoViewModel>().todos[index],
                              );
                            });
                        context.read<TodoViewModel>().fetchTodos();
                      },
                      child: TodoCard(
                        todo: context.watch<TodoViewModel>().todos[index],
                      ),
                    ),
                    itemCount: context.watch<TodoViewModel>().todos.length,
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
