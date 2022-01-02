import 'package:flutter/material.dart';

void displayDatePicker(context) {
  showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime.now())
      .then((pickedDate) {
    if (pickedDate == null)
      return;
    else
      null;
  });
}
