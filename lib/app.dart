import 'package:flutter/material.dart';
import 'package:note_app/ui/routes/routes_generator.dart';
import 'package:note_app/utils/size_util.dart';
import 'package:note_app/viewModels/note_view_model.dart';
import 'package:note_app/viewModels/todo_view_model.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeUtil.init(context);
    return MultiProvider(
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
    );
  }
}
