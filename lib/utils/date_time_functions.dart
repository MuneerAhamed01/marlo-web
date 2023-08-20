import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDateTimeRange(DateTimeRange range) {
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final String formattedStart = formatter.format(range.start);
  final String formattedEnd = formatter.format(range.end);

  return '$formattedStart - $formattedEnd';
}


