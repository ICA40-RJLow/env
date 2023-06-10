import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QCDataInquiryApp extends StatelessWidget {
  const QCDataInquiryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QC Data Inquiry',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QCDataInquiryPage(),
    );
  }
}

class QCDataInquiryPage extends StatefulWidget {
  const QCDataInquiryPage({super.key});

  @override
  State <QCDataInquiryPage> createState() => _QCDataInquiryPageState();
}

class _QCDataInquiryPageState extends State<QCDataInquiryPage> {
  List<String> dataList = [
    'Apple',
    'Banana',
    'Orange',
    'Mango',
    'Grapes',
    'Pineapple',
    'Watermelon',
    'Peach',
    'Pear',
  ];

  List<String> filteredList = [];

  TextEditingController dateRangeController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  TextEditingController jobOrderNoController = TextEditingController();
  TextEditingController processController = TextEditingController();
  TextEditingController machineController = TextEditingController();

  @override
  void initState() {
    filteredList = dataList;
    super.initState();
  }

  void filterData(String searchText) {
    if (searchText.isEmpty) {
      setState(() {
        filteredList = dataList;
      });
      return;
    }

    List<String> tempList = [];
    for (var data in dataList) {
      if (data.toLowerCase().contains(searchText.toLowerCase())) {
        tempList.add(data);
      }
    }

    setState(() {
      filteredList = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QC Data Inquiry'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: dateRangeController,
              readOnly: true,
              onTap: () => showDatePickerDialog(context),
              decoration: const InputDecoration(
                labelText: 'Date Range',
                border: OutlineInputBorder(),
              ),
            )
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    title: Text(filteredList[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void showDatePickerDialog(BuildContext context) async {
    final initialDate = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (selectedDate != null) {
      setState(() {
        if (startDate == null) {
          startDate = selectedDate;
        } else if (endDate == null) {
          if (selectedDate.isAfter(startDate!)) {
            endDate = selectedDate;
          } else {
            // Show an error message if the end date is before the start date.
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Invalid Date'),
                  content: const Text('Please select an end date after the start date.'),
                  actions: [
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                );
              },
            );
          }
        } else {
          startDate = DateFormat('dd-MM-yyyy').format(selectedDate) as DateTime?;
          endDate = null;
        }

        // Update the text field's value.
        dateRangeController.text =
        '${startDate.toString()} - ${endDate.toString()}';
      });
    }
  }

}

