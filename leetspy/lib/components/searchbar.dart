import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Function(String) onSubmitted;

  const SearchBar({Key? key, required this.onSubmitted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Enter username...',
        prefixIcon: Icon(Icons.search),
      ),
      onSubmitted: onSubmitted,
    );
  }
}
