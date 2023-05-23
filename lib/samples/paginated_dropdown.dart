import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Paginated Dropdown Example')),
        body: const Center(
          child: PaginatedDropdown(),
        ),
      ),
    );
  }
}

class PaginatedDropdown extends StatefulWidget {
  const PaginatedDropdown({super.key});

  @override
  _PaginatedDropdownState createState() => _PaginatedDropdownState();
}

class _PaginatedDropdownState extends State<PaginatedDropdown> {
  int currentPage = 1;
  int itemsPerPage = 10;
  List<String> allItems = [];
  List<String> displayedItems = [];
  bool isLoading = false;
  String selectedItem = '';

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      // Simulating API request delay
      await Future.delayed(const Duration(seconds: 2));

      // Fetch items for the current page
      final response = await http.get(Uri.parse(
          'https://jsonplaceholder.typicode.com/posts?_page=$currentPage&_limit=$itemsPerPage'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<String> fetchedItems =
        responseData.map<String>((item) => item['title']).toList();

        allItems.addAll(fetchedItems);
        displayedItems.addAll(fetchedItems);
        selectedItem = displayedItems.first;
      } else {
        // Error handling if API request fails
        debugPrint('Failed to fetch items. Error: ${response.statusCode}');
      }
    } catch (e) {
      // Error handling if an exception occurs
      debugPrint('Failed to fetch items. Exception: $e');
    }

    setState(() {
      isLoading = false;
    });
  }

  void nextPage() {
    if (currentPage * itemsPerPage < allItems.length) {
      currentPage++;
      updateDisplayedItems();
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      updateDisplayedItems();
    }
  }

  void updateDisplayedItems() {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    displayedItems = allItems.sublist(startIndex, endIndex);
    selectedItem = displayedItems.last;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              DropdownButton<String>(
                value: selectedItem,
                items: displayedItems.map<DropdownMenuItem<String>>(
                      (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedItem = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              if (selectedItem != null)
                Text('Selected Item: $selectedItem'),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: previousPage,
                    child: const Text('Previous'),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: nextPage,
                    child: const Text('Next'),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              if (isLoading)
                const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }}
