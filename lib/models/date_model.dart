import 'package:cloud_firestore/cloud_firestore.dart';
const String datetimestamp = 'timestamp';
const String dateday = 'day';
const String datemonth = 'month';
const String dateyear = 'year';

class DateModel {
  Timestamp timestamp;
  int day, month, year;

  DateModel(
      {required this.timestamp,
      required this.day,
      required this.month,
      required this.year});

  Map<String, dynamic> toMap() => <String, dynamic>{
    datetimestamp: timestamp,
        dateday: day,
        datemonth: month,
        dateyear: year
      };

  factory DateModel.fromMap(Map<String, dynamic> map) => DateModel(
        timestamp: map[datetimestamp],
        day: map[dateday],
        month: map[datemonth],
        year: map[dateyear],
      );
}
