import 'package:flutter/material.dart';

Future<DateTimeRange?> showPopUp(BuildContext context) async {
  return await showDateRangePicker(
    context: context,
    firstDate: DateTime(1777),
    lastDate: DateTime.now(),
    builder: (context, child) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 500,
          width: 500,
          child: child,
        ),
      ],
    ),
  );
}
