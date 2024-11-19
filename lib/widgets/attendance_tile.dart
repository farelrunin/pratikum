import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceTile extends StatelessWidget {
  final Map<String, dynamic> record;
  final Function onTap;

  AttendanceTile({required this.record, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd-MMM-yyyy').format(record['date']);
    return ListTile(
      tileColor: record['absent'] > record['present']
          ? Colors.red[50]
          : Colors.green[50],
      title: Text(
        formattedDate,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        'Hadir: ${record['present']}, Tidak Hadir: ${record['absent']}',
        style: TextStyle(color: Colors.black87),
      ),
      onTap: () => onTap(),
    );
  }
}
