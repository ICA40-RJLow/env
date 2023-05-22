import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Machine {
  final int id;
  final String description;

  Machine({required this.id, required this.description});
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State <MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Machine> machines = [];
  int? selectedId;

  @override
  void initState() {
    super.initState();
    fetchMachineData();
  }

  Future<void> fetchMachineData() async {
    final url = Uri.parse('https://adaaierp.com:9011/api/v1/production/ProdMachine/list');
    final headers = {
      'content-type': 'application/json',
      'x-client-id': 'adaai',
      'x-secure-key': 'dSN43Z8Y8uh6Xvss',
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbkBhYmMuY29tIiwianRpIjoiZTk4YzkzMDktM2M5ZS00MzU1LWEyOTAtZjhmNWU0ZGFhYTdhIiwiZW1haWwiOiJhZG1pbkBhYmMuY29tIiwiaWQiOiIxIiwidHlwZSI6IkEiLCJvcmciOiIiLCJicmFuY2giOiIiLCJpc19wdXJfYXBwciI6IlkiLCJpc19zYWxfYXBwciI6IlkiLCJuYmYiOjE2ODQ3MzM3MjksImV4cCI6MTY4NDc3NjkyOSwiaWF0IjoxNjg0NzMzNzI5fQ.ca9ijSwvDhZE3Y78ioG5PsYKYORCeAlrV8PBTALfF4E',
    };

    final response = await http.get(url, headers: headers);

    debugPrint('Response Body: ${response.body}');


    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      setState(() {
        machines = data.map((machine) {
          return Machine(
              id: machine['id'],
              description: machine['description']
          );
        }).toList();
      });
    } else {
      throw Exception('Failed to fetch machine data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Machine List'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<int>(
                value: selectedId,
                onChanged: (int? newValue) {
                  setState(() {
                    selectedId = newValue!;
                  });
                },
                items: machines.map<DropdownMenuItem<int>>((Machine machine) {
                  return DropdownMenuItem<int>(
                    value: machine.id,
                    child: Text(machine.description),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Text(
                selectedId != null
                    ? 'Selected Description: ${machines.firstWhere((machine) => machine.id == selectedId!).description}'
                    : 'No machine selected',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
