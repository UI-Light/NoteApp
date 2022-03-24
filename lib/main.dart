import 'package:flutter/material.dart';
import 'package:note_app/viewModels/note_view_model.dart';
import 'package:note_app/viewModels/todo_view_model.dart';
import 'package:note_app/ui/views/page_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<NoteViewModel>(
          create: ((_) => NoteViewModel()),
        ),
        ChangeNotifierProvider<TodoViewModel>(
          create: ((_) => TodoViewModel()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
        theme: ThemeData(),
      ),
    ),
  );
}
