import "package:flutter/material.dart";
import 'package:note_app/data/database_service.dart';
import 'package:note_app/models/note.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  List<Note> notes = [];
  String query = '';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        fetchNotes();
      } else {
        setState(() {
          filterSearch(query);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: TextField(
        onChanged: (value) => filterSearch,
        controller: searchController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          suffixIcon: searchController.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close),
                  onTap: () => searchController.clear(),
                )
              : null,
          hintText: 'Search notes',
          border: InputBorder.none,
        ),
      ),
    );
  }

  void fetchNotes() async {
    var dataBaseService = DataBaseService();
    notes = await dataBaseService.fetchNotes();
    setState(() {});
  }

  void filterSearch(String keyword) {
    final searchNotes = notes.where((note) {
      final searchTitle =
          note.title.toLowerCase().contains(query.toLowerCase());
      final searchBody = note.body.toLowerCase().contains(query.toLowerCase());
      return searchTitle || searchBody;
    }).toList();
    setState(() {
      notes = searchNotes;
    });
  }
}
