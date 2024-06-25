import 'package:flutter/material.dart';

class DatePickerProvider extends ChangeNotifier {
  // int? daysDifference;
  DateTime? currentDateTime;

  void changeDate(DateTime dateTime) {
    currentDateTime = dateTime;
    notifyListeners();
  }

  Future<DateTime> mainPicker(context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
        currentDate: currentDateTime);

    if (pickedDate != null) {
      return DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
      );
    }

    return DateTime.now();
  }
}
