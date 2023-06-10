import 'package:flutter/material.dart';

class QCDataDetailsPage extends StatelessWidget {
  final List<QCData> qcDataList = [
    QCData(
      date: '2023-06-10',
      process: 'Process A',
      machine: 'Machine 1',
      partNo: 'ABC123',
      jobOrder: 'JO123',
      reportBy: 'John Doe',
      comment: 'Some comment here',
    ),
    // Add more QCData objects here...
  ];

  QCDataDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QC Data Details'),
      ),
      body: ListView.builder(
        itemCount: qcDataList.length,
        itemBuilder: (context, index) {
          final qcData = qcDataList[index];
          return Card(
            child: ListTile(
              title: Text('Date: ${qcData.date}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Process: ${qcData.process}'),
                  Text('Machine: ${qcData.machine}'),
                  Text('Part No: ${qcData.partNo}'),
                  Text('Job Order: ${qcData.jobOrder}'),
                  Text('Report By: ${qcData.reportBy}'),
                  Text('Comment: ${qcData.comment}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class QCData {
  final String date;
  final String process;
  final String machine;
  final String partNo;
  final String jobOrder;
  final String reportBy;
  final String comment;

  QCData({
    required this.date,
    required this.process,
    required this.machine,
    required this.partNo,
    required this.jobOrder,
    required this.reportBy,
    required this.comment,
  });
}

void main() {
  runApp(MaterialApp(
    home: QCDataDetailsPage(),
  ));
}
