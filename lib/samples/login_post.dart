import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test_program/samples/data_entry_sample.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State <LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _password;

  Future<String?> _login() async {
    final formState = _formKey.currentState;
    if (formState != null && formState.validate()) {
      formState.save();

      final headers = {
        'x-client-id': 'adaai',
        'x-secure-key': 'dSN43Z8Y8uh6Xvss',
        "content-type":"application/json"
      };

      final body = {
        'user_id': _email,
        'user_pwd': _password,
      };

      final response = await http.post(
        Uri.parse('https://adaaierp.com:9011/api/v1/user/login'),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        // Login successful, proceed to the next screen
        const MyCustomClass().myAsyncMethod(() {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const QCDataEntryApp()),
          );
          final jsonResponse = json.decode(response.body);
          debugPrint('$jsonResponse');
          final token = jsonResponse['token'];
          debugPrint('$token');
          return token;
        });
      } else {
        // Login failed, handle the error
        debugPrint('Login failed: ${response.statusCode} - ${response.body}');
        return null;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onSaved: (value) => _password = value!,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _login(),
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      );

  }
}

class MyCustomClass {
  const MyCustomClass();

  void myAsyncMethod(Function callback) async {
    await Future.delayed(const Duration(seconds: 2));
    callback();
  }
}


