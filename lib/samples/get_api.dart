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

  Future<String?> fetchToken() async{
    final url = Uri.parse('https://adaaierp.com:9011/api/v1/user/login');

    final headers = {
      'content-type': 'application/json',
      'x-client-id': 'adaai',
      'x-secure-key': 'dSN43Z8Y8uh6Xvss',
    };

    final body = {
      "user_id": "admin",
      "user_pwd": "Adaa12023"
    };

    final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body)
    );

    if (response.statusCode == 200) {
      debugPrint('GET Token Successful');
      final jsonResponse = json.decode(response.body);
      final token = jsonResponse['token'];
      if (token is String) {
        debugPrint('token is a string');
      }
      return token;
    } else {
      debugPrint('Request failed with status[1]: ${response.statusCode}');
      return null;
    }
  }

  void fetchData() async {
    final token = await fetchToken();
    const url = 'https://adaaierp.com:9011/api/v1/production/JobOrderMaster/PageList';

    Map<String, String> headers = {
      'content-type': 'application/json',
      'x-client-id': 'adaai',
      'x-secure-key': 'dSN43Z8Y8uh6Xvss',
      'Authorization': 'Bearer $token'
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
      debugPrint('Request failed with status[2]: ${response.statusCode}');
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
