import 'package:note_app/data/database_service.dart';
import 'package:note_app/domain/models/todo.dart';
import 'package:note_app/domain/repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  late DataBaseService dataBaseService;
  TodoRepositoryImpl() {
    dataBaseService = DataBaseService();
  }

  Future<List<Todo>> fetchTodos() async {
    return await dataBaseService.fetchTodos();
  }

  Future<void> saveEvent({required String event}) async {
    await dataBaseService.insertTodo(Todo(
      event: event,
      date: DateTime.now(),
      id: DateTime.now().toIso8601String(),
    ));
  }

  Future<void> editTodo({required String event, required String id}) async {
    await dataBaseService.updateTodo(
      Todo(
        event: event,
        date: DateTime.now(),
        id: id,
      ),
    );
  }

  Future<void> deleteTodo(String id) async {
    await dataBaseService.deleteTodo(id);
  }
}
