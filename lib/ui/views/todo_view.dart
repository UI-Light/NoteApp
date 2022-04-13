import 'package:flutter/material.dart';
import 'package:note_app/models/todo.dart';
import 'package:note_app/ui/routes/routes.dart';
import 'package:note_app/ui/shared/search_bar.dart';
import 'package:note_app/ui/shared/todo_bottom_sheet.dart';
import 'package:note_app/ui/shared/todo_card.dart';
import 'package:note_app/ui/shared/edit_bottom_sheet.dart';
import 'package:note_app/utils/size_util.dart';
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
    super.initState();
    searchTodoController.addListener(() {
      if (searchTodoController.text.isEmpty) {
        context.read<TodoViewModel>().fetchTodos();
      } else {
        context.read<TodoViewModel>().filterTodo(searchTodoController.text);
      }
    });

    Future.microtask(() => context.read<TodoViewModel>().fetchTodos());
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<TodoViewModel, bool>(
        ((todoViewModel) => todoViewModel.isLoading));
    final todos = context.select<TodoViewModel, List<Todo>>(
        ((todoViewModel) => todoViewModel.todos));

    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            20.w,
            // SizeUtil.width(20),
            70.h,
            // SizeUtil.height(70),
            20.w,
            // SizeUtil.width(20),
            0,
          ),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'To-dos',
                  style: TextStyle(
                    // fontSize: SizeUtil.textSize(30),
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              SearchBar(
                  controller: searchTodoController, hintText: 'Search to-dos'),
              SizedBox(height: 20.h),
              Expanded(
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          //bool ? true:bool?true:false
                          valueColor: AlwaysStoppedAnimation(Colors.green),
                          backgroundColor: Colors.grey,
                        ),
                      )
                    : !isLoading && todos.isEmpty
                        ? Center(child: Text("No Todo"))
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) => GestureDetector(
                              onLongPress: () {
                                Navigator.of(context).pushNamed(
                                    Routes.deleteTodoRoute,
                                    arguments: [todos, index]);
                                //   Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (context) => DeleteTodosView(
                                //       todos: todos,
                                //       index: index,
                                //     ),
                                //   ),
                                // );
                              },
                              onTap: () async {
                                await showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return EditBottomSheet(
                                        todo: todos[index],
                                      );
                                    });
                                context.read<TodoViewModel>().fetchTodos();
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
