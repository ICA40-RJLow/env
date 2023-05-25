import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> dataList = [];
  int? selectedId;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    const url = 'https://adaaierp.com:9011/api/v1/production/JobOrderMaster/PageList';

    // Set the headers for the request
    Map<String, String> headers = {
      'content-type': 'application/json',
      'x-client-id': 'adaai',
      'x-secure-key': 'dSN43Z8Y8uh6Xvss',
      'Authorization':
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbkBhYmMuY29tIiwianRpIjoiNTJmY2QwOTktMDk0Ni00OGFjLWIxMzItNjRkMDRiNDcxZDI3IiwiZW1haWwiOiJhZG1pbkBhYmMuY29tIiwiaWQiOiIxIiwidHlwZSI6IkEiLCJvcmciOiIiLCJicmFuY2giOiIiLCJpc19wdXJfYXBwciI6IlkiLCJpc19zYWxfYXBwciI6IlkiLCJuYmYiOjE2ODQ4OTMxMDAsImV4cCI6MTY4NDkzNjMwMCwiaWF0IjoxNjg0ODkzMTAwfQ.MTEpWHrXECpvjg1mqGzegrEkoE6rCNEeGICDNPLllGg',
    };

    // Send the HTTP GET request
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      // Parsing the response body
      final responseData = json.decode(response.body);

      // Access the 'data' field in the response
      final dataListResponse = responseData['data'];

      if (dataListResponse is List) {
        setState(() {
          // Update the 'dataList' variable to store the response data
          dataList = List<Map<String, dynamic>>.from(dataListResponse);
        });
      }
    } else {
      // If the request fails, handle the error
      debugPrint('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Example'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: DropdownButton<int>(
            value: selectedId,
            hint: const Text('Select DSCP'),
            items: dataList.map((item) {
              return DropdownMenuItem<int>(
                value: item['id'] as int,
                child: Text(item['code'] as String),
              );
            }).toList(),
            onChanged: (int? newValue) {
              setState(() {
                selectedId = newValue!;
              });
            },
          ),
        ),
      ),
    );
  }
}

