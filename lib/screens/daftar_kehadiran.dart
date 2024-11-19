import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/nama.dart';

class DaftarKehadiran extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Nama>(context);
    final students = provider.students;

    return Scaffold(
      appBar: AppBar(title: Text('Presensi Siswa'), backgroundColor: Colors.blue,),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (ctx, index) {
                return StudentTile(index: index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: students.isEmpty
                  ? null
                  : () {
                      provider.saveAttendance();
                    },
              child: Text('Simpan'),
            ),
          ),
        ],
      ),
    );
  }
}

class StudentTile extends StatelessWidget {
  final int index;

  const StudentTile({required this.index});

  @override
  Widget build(BuildContext context) {
    final student = Provider.of<Nama>(context).students[index];
    final isPresent = student['isPresent'];

    return ListTile(
      tileColor: isPresent ? Colors.green[50] : Colors.red[50], // Warna sesuai kehadiran
      title: Text(
        student['name'],
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isPresent ? Colors.green : Colors.red,
        ),
      ),
      trailing: Checkbox(
        value: isPresent,
        onChanged: (value) {
          // Mengubah status kehadiran siswa
          Provider.of<Nama>(context, listen: false).toggleAttendance(index);
        },
      ),
    );
  }
}
