import 'package:flutter/material.dart';

class QCDataEntryApp extends StatefulWidget {
  const QCDataEntryApp({super.key});

  @override
  State<QCDataEntryApp> createState() => _QCDataEntryAppState();
}

class _QCDataEntryAppState extends State<QCDataEntryApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QC Data Entry',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QCDataEntryScreen(),
    );
  }
}

class QCDataEntryScreen extends StatefulWidget {
  const QCDataEntryScreen({super.key});

  @override
  State<QCDataEntryScreen> createState() => _QCDataEntryScreenState();
}

class _QCDataEntryScreenState extends State<QCDataEntryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QC Data Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _passwordController,
                obscureText: !_passwordVisible,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  // Add more password validation logic if needed
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                child: Text(_passwordVisible ? 'Hide Password' : 'Show Password'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Perform login or form submission logic
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

// ... other code ...
}


// class _QCDataEntryScreenState extends State<QCDataEntryScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _productNameController = TextEditingController();
//   final TextEditingController _productCodeController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('QC Data Entry'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _productNameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Product Name',
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a product name';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _productCodeController,
//                 decoration: const InputDecoration(
//                   labelText: 'Product Code',
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a product code';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     // Perform data entry here
//                     String productName = _productNameController.text;
//                     String productCode = _productCodeController.text;
//                     _submitData(productName, productCode);
//                   }
//                 },
//                 child: const Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _submitData(String productName, String productCode) {
//     // Perform your QC data entry logic here
//     // You can send the data to an API or save it locally, etc.
//     debugPrint('Product Name: $productName');
//     debugPrint('Product Code: $productCode');
//     // Clear the form fields after submission
//     _productNameController.clear();
//     _productCodeController.clear();
//   }
// }