import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/nama.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final history = Provider.of<Nama>(context).history;

    return Scaffold(
      appBar: AppBar(title: Text('Riwayat Kehadiran')),
      body: history.isEmpty
          ? Center(child: Text('Belum ada riwayat.'))
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (ctx, index) {
                final record = history[index];
                return AttendanceTile(
                  record: record,
                  onTap: () {
                    showAttendanceDetails(context, record);
                  },
                );
              },
            ),
    );
  }

  void showAttendanceDetails(BuildContext context, Map<String, dynamic> record) {
    final provider = Provider.of<Nama>(context, listen: false);
    final presentStudents = provider.students
        .where((student) => student['isPresent'])
        .map((student) => student['name'])
        .toList();
    final absentStudents = provider.students
        .where((student) => !student['isPresent'])
        .map((student) => student['name'])
        .toList();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Detail Kehadiran'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Tanggal: ${DateFormat('dd-MMM-yyyy').format(record['date'])}'),
            SizedBox(height: 10),
            Text('Siswa yang Hadir:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(presentStudents.isNotEmpty ? presentStudents.join(', ') : 'Tidak ada siswa yang hadir'),
            SizedBox(height: 10),
            Text('Siswa yang Tidak Hadir:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(absentStudents.isNotEmpty ? absentStudents.join(', ') : 'Tidak ada siswa yang tidak hadir'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Tutup'),
          ),
        ],
      ),
    );
  }
}

class AttendanceTile extends StatelessWidget {
  final Map<String, dynamic> record;
  final VoidCallback onTap;

  AttendanceTile({required this.record, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isMoreAbsent = record['absent'] > record['present'];

    return ListTile(
      tileColor: isMoreAbsent ? const Color.fromARGB(255, 11, 174, 250) : Colors.green[50], // Warna kolom
      title: Text(
        DateFormat('dd-MMM-yyyy').format(record['date']),
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        'Hadir: ${record['present']}, Tidak Hadir: ${record['absent']}',
        style: TextStyle(
          color: isMoreAbsent ? const Color.fromARGB(255, 88, 255, 22) : Colors.green,
        ),
      ),
      onTap: onTap,
    );
  }
}
