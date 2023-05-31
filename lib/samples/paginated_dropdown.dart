import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Paginated Dropdown Sample')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: PaginatedDropdown(),
          ),
        ),
      ),
    );
  }
}

class PaginatedDropdown extends StatefulWidget {
  const PaginatedDropdown({super.key});

  @override
  State<PaginatedDropdown> createState() => _PaginatedDropdownState();
}

class _PaginatedDropdownState extends State<PaginatedDropdown> {
  List<String> items = [
    "Apple",
    "Banana",
    "Cherry",
    "Date",
    "Elderberry",
    "Fig",
    "Grapes",
    "Honeydew",
    "Kiwi",
    "Lemon",
    "Mango",
    "Orange",
    "Peach",
    "Quince",
    "Raspberry",
    "Strawberry",
    "Watermelon"
  ];
  int itemsPerPage = 3;
  int currentPage = 1;

  List<String> getCurrentPageItems() {
    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    return items.sublist(startIndex, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    List<String> currentPageItems = getCurrentPageItems();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Page $currentPage',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: currentPageItems[0],
              onChanged: (String? newValue) {},
              items: currentPageItems.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: currentPage > 1
                      ? () {
                    setState(() {
                      currentPage--;
                    });
                  }
                      : null,
                  child: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: currentPage * itemsPerPage < items.length
                      ? () {
                    setState(() {
                      currentPage++;
                    });
                  }
                      : null,
                  child: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
