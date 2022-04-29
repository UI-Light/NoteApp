import 'package:flutter/material.dart';
import 'package:note_app/domain/models/note.dart';
import 'package:note_app/ui/routes/routes.dart';
import 'package:note_app/ui/views/delete_todos_view.dart';
import 'package:note_app/ui/views/edit_note_view.dart';
import 'package:note_app/ui/views/new_note_view.dart';
import 'package:note_app/ui/views/page_view.dart';

class RouteGenerator {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.pageViewRoute:
        return _getPageRoute(Home());
      case Routes.newNoteRoute:
        return _getPageRoute(CreateNote());
      case Routes.editNoteRoute:
        return _getPageRoute(EditNote(note: routeSettings.arguments as Note));
      case Routes.deleteTodoRoute:
        List arguments = routeSettings.arguments as List;
        // arguments: [todos, index]
        return _getPageRoute(
            DeleteTodosView(todos: arguments.first, index: arguments.last));
      default:
    }
  }

  static MaterialPageRoute? _getPageRoute(
    Widget child, [
    RouteSettings routeSettings = const RouteSettings(),
  ]) {
    return MaterialPageRoute(
      builder: (_) => child,
      settings: routeSettings,
    );
  }
}
