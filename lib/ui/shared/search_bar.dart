import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const SearchBar({Key? key, required this.controller, required this.hintText})
      : super(key: key);

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
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: controller.text.isNotEmpty ? Colors.green : Colors.grey,
          ),
          suffixIcon: controller.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(
                    Icons.close,
                    color:
                        controller.text.isNotEmpty ? Colors.green : Colors.grey,
                  ),
                  onTap: () => controller.clear(),
                )
              : null,
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
