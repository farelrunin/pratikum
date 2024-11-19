import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/providers/nama.dart';
// ignore: duplicate_import
import '../providers/nama.dart';

class Siswa_Title extends StatelessWidget {
  final int index;

  const Siswa_Title ({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final student = Provider.of<Nama>(context).students[index];

    return ListTile(
      title: Text(student['name']),
      trailing: Checkbox(
        value: student['isPresent'],
        onChanged: (value) {
          Provider.of<Nama>(context, listen: false)
              .toggleAttendance(index);
        },
      ),
    );
  }
}
