import "package:flutter/material.dart";
import 'package:note_app/ui/views/notes_view.dart';
import 'package:note_app/ui/views/todo_view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          NoteView(),
          TodoView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[200],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sticky_note_2_outlined,
              size: 18,
            ),
            label: "Notes",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.today_outlined,
              size: 18,
            ),
            label: "To-dos",
          ),
        ],
        onTap: (index) {
          pageController.jumpToPage(index);
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
