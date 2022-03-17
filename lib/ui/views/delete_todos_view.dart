import 'package:flutter/material.dart';
import 'package:note_app/data/database_service.dart';
import 'package:note_app/models/todo.dart';
import 'package:note_app/ui/shared/delete_todo_card.dart';

class DeleteTodosView extends StatefulWidget {
  final List<Todo> todos;
  final int index;
  const DeleteTodosView({Key? key, required this.todos, required this.index})
      : super(key: key);

  @override
  State<DeleteTodosView> createState() => _DeleteTodosViewState();
}

class _DeleteTodosViewState extends State<DeleteTodosView> {
  List<bool> checkedBoxStatus = [];
  bool isChecked = false;

  void deleteTodo(String id) async {
    DataBaseService dataBaseService = DataBaseService();
    await dataBaseService.deleteTodo(id);
  }

  void onPressed() async {
    for (var i = 0; i < checkedBoxStatus.length; i++) {
      if (checkedBoxStatus[i]) {
        deleteTodo(widget.todos[i].id);
      }
    }
    Navigator.of(context).pop();
  }

  int get selectedItemsCount =>
      checkedBoxStatus.where((status) => status == true).length;

  void checkBoxChildrenStatus(int index) {
    setState(() {
      bool value = checkedBoxStatus[index];
      checkedBoxStatus[index] = !value;
      isChecked = checkedBoxStatus.every((element) => element == true);
    });
  }

  @override
  void initState() {
    super.initState();
    checkedBoxStatus = List.generate(widget.todos.length, (index) => false);
    checkedBoxStatus[widget.index] = true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.close,
              color: Colors.green,
            ),
          ),
          title: Text(
            selectedItemsCount == 0
                ? 'Please select items'
                : '$selectedItemsCount selected items',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          actions: [
            Checkbox(
                activeColor: Colors.green,
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                    if (isChecked) {
                      checkedBoxStatus =
                          List.generate(widget.todos.length, (index) => true);
                    } else {
                      checkedBoxStatus =
                          List.generate(widget.todos.length, (index) => false);
                    }
                  });
                })
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemBuilder: (context, index) => DeleteTodoCard(
              todo: widget.todos[index],
              isChecked: checkedBoxStatus[index],
              onChanged: () {
                checkBoxChildrenStatus(index);
              },
            ),
            itemCount: widget.todos.length,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.grey[200],
          child: IconButton(
            onPressed: () async {
              onPressed();
            },
            icon: Icon(
              Icons.delete_outline_sharp,
            ),
          ),
        ),
      ),
    );
  }
}
