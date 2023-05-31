import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TypeAhead extends StatelessWidget {
  const TypeAhead({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TypeAheadField Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TypeAheadPage(),
    );
  }
}

class TypeAheadPage extends StatefulWidget {
  const TypeAheadPage({super.key});

  @override
  State<TypeAheadPage> createState() => _TypeAheadPageState();
}

class _TypeAheadPageState extends State<TypeAheadPage> {
  final List<String> options = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grape',
    'Honeydew',
    'Lemon',
    'Mango',
    'Orange',
    'Peach',
    'Quince',
    'Raspberry',
    'Strawberry',
    'Watermelon',
  ];

  final TextEditingController _selectedOptionController = TextEditingController();

  @override
  void dispose() {
    _selectedOptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TypeAheadField Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _selectedOptionController,
                decoration: const InputDecoration(
                  labelText: 'Select a fruit',
                ),
              ),
              suggestionsCallback: (pattern) {
                return _getFilteredOptions(pattern);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion),
                );
              },
              onSuggestionSelected: (suggestion) {
                setState(() {
                  _selectedOptionController.text = suggestion;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  List<String> _getFilteredOptions(String pattern) {
    return options
        .where((option) => option.toLowerCase().contains(pattern.toLowerCase()))
        .toList();
  }
}

