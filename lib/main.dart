import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:note_app/ui/routes/routes_generator.dart';
import 'package:note_app/viewModels/note_view_model.dart';
import 'package:note_app/viewModels/todo_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MultiProvider(
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
          //home: Home(),
          theme: ThemeData(),
          onGenerateRoute: RouteGenerator.onGenerateRoute,
        ),
      ),
    ),
  );
}
