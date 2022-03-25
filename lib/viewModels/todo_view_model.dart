import 'package:flutter/material.dart';
import 'package:note_app/data/database_service.dart';

import 'package:note_app/models/todo.dart';

class TodoViewModel extends ChangeNotifier {
  List<Todo> _todos = [];
  List<Todo> _unfilteredTodos = [];
  List<Todo> get todos => _todos;
  bool _isLoading = false;

  void fetchTodos() async {
    DataBaseService dataBaseService = DataBaseService();
    _unfilteredTodos = _todos = await dataBaseService.fetchTodos();
    notifyListeners();
  }

  void saveEvent({required String event}) async {
    DataBaseService dataBaseService = DataBaseService();
    await dataBaseService.insertTodo(Todo(
      event: event,
      date: DateTime.now(),
      id: DateTime.now().toIso8601String(),
    ));
    fetchTodos();
  }

  void editTodo({required String event, required String id}) async {
    DataBaseService dataBaseService = DataBaseService();
    await dataBaseService.updateTodo(
      Todo(
        event: event,
        date: DateTime.now(),
        id: id,
      ),
    );
    fetchTodos();
  }

  void deleteTodo(String id) async {
    DataBaseService dataBaseService = DataBaseService();
    await dataBaseService.deleteTodo(id);
    fetchTodos();
  }

  void filterTodo(String keyword) {
    final searchTodos = _unfilteredTodos.where((todo) {
      final containsEvent =
          todo.event.toLowerCase().contains(keyword.toLowerCase());
      return containsEvent;
    }).toList();
    _todos = searchTodos;
    notifyListeners();
  }
}
