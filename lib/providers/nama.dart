import 'package:flutter/material.dart';

class Nama with ChangeNotifier {
  final List<Map<String, dynamic>> _students = [
    {'name': 'Ali', 'isPresent': false},
    {'name': 'Budi', 'isPresent': false},
    {'name': 'Citra', 'isPresent': false},
  ];

  final List<Map<String, dynamic>> _history = [];

  List<Map<String, dynamic>> get students => _students;
  List<Map<String, dynamic>> get history => _history;

  void toggleAttendance(int index) {
    _students[index]['isPresent'] = !_students[index]['isPresent'];
    notifyListeners();
  }

  void saveAttendance() {
    final date = DateTime.now();
    final presentCount = _students.where((student) => student['isPresent']).length;
    final absentCount = _students.length - presentCount;

    _history.insert(0, {
      'date': date,
      'present': presentCount,
      'absent': absentCount,
    });

    // Reset attendance
    for (var student in _students) {
      student['isPresent'] = false;
    }
    notifyListeners();
  }
}
