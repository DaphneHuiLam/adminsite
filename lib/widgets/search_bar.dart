// lib/widgets/search_bar.dart

import 'package:flutter/material.dart';
import '../services/search_service.dart';

class SearchBar extends StatefulWidget {
  final SearchService searchService;
  final ValueChanged<String> onSearchChanged;
  final String pageTitle;

  SearchBar({
    required this.searchService,
    required this.onSearchChanged,
    required this.pageTitle,
  });

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _searchController = TextEditingController();

  void _onSearch() {
    widget.onSearchChanged(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.pageTitle,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Enter search query',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: _onSearch,
              ),
            ),
            onChanged: (query) {
              widget.onSearchChanged(query);
            },
          ),
        ),
      ],
    );
  }
}
