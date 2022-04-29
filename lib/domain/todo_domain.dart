import 'package:flutter/material.dart';
import 'package:note_app/domain/models/todo.dart';
import 'package:note_app/domain/repository.dart';

class TodoDomain {
  late TodoRepository todoRepository;
  TodoDomain(this.todoRepository);

  ValueNotifier<List<Todo>> _todos = ValueNotifier([]);
  ValueNotifier<List<Todo>> get todos => _todos;

  Future<void> fetchTodos() async {
    _todos.value = await todoRepository.fetchTodos();
  }

  void saveEvent({required String event}) async {
    await todoRepository.saveEvent(event: event);
    fetchTodos();
  }

  void editTodo({required String event, required String id}) async {
    await todoRepository.editTodo(event: event, id: id);
    fetchTodos();
  }

  void deleteTodo(String id) async {
    await todoRepository.deleteTodo(id);
    fetchTodos();
  }
}
