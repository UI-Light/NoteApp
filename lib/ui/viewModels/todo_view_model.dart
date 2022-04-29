import 'package:flutter/material.dart';
import 'package:note_app/data/repository/todos_repository.dart';
import 'package:note_app/domain/models/todo.dart';
import 'package:note_app/domain/todo_domain.dart';

class TodoViewModel extends ChangeNotifier {
  TodoViewModel() {
    init();
  }

  List<Todo> _todos = [];
  List<Todo> _unfilteredTodos = [];
  List<Todo> get todos => _todos;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
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

  //Depend on the domain relevant to the viewmodel
  final todoDomain = TodoDomain(TodoRepositoryImpl());

  //Expose a getter that retrieves the required data from the domain
  ValueNotifier<List<Todo>> get todo => todoDomain.todos;

  void init() {
    todoDomain.todos.addListener(() {
      _todos = _unfilteredTodos = todoDomain.todos.value;
      notifyListeners();
    });
  }

  void fetchTodos() async {
    setLoading(true);
    await todoDomain.fetchTodos();
    setLoading(false);
  }

  void saveEvent({required String event}) {
    todoDomain.saveEvent(event: event);
  }

  void editTodo({required String event, required String id}) {
    todoDomain.editTodo(event: event, id: id);
  }

  void deleteTodo(String id) {
    todoDomain.deleteTodo(id);
  }
}
