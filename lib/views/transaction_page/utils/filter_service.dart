import 'package:flutter/material.dart';
import 'package:sample/utils/enums.dart';
import 'package:sample/utils/extensions.dart';
import 'package:sample/views/transaction_page/model/transaction_model.dart';

class FilterService {
  FilterService._();

  static FilterService instance = FilterService._();

  List<TransactionModel> sourceTypeFilter(
      List<TransactionModel> list, List<SourceType> filter) {
    List<TransactionModel> transaction = [];

    for (var items in list) {
      for (var type in filter) {
        if (type.values.contains(items.sourceType)) {
          transaction.add(items);
        }
      }
    }
    return transaction;
  }

  List<TransactionModel> currenciesFilter(
      List<TransactionModel> list, List<String> currencies) {
    List<TransactionModel> transaction = [];

    for (var items in list) {
      for (var currency in currencies) {
        if (items.currency1 == currency) {
          transaction.add(items);
        }
      }
    }
    return transaction;
  }

  List<TransactionModel> statusFilter(
      List<TransactionModel> list, List<String> statuses) {
    List<TransactionModel> transaction = [];

    for (var items in list) {
      for (var status in statuses) {
        if (items.status == status) {
          transaction.add(items);
        }
      }
    }
    return transaction;
  }

  List<TransactionModel> dateFilter(
      List<TransactionModel> list, DateTimeRange range) {
    return list
        .where((element) => _isTimeInRange(element.createdAt, range))
        .toList();
  }

  bool _isTimeInRange(DateTime dateToCheck, DateTimeRange range) {
    final startDate =
        DateTime(range.start.year, range.start.month, range.start.day);
    final endDate = DateTime(range.end.year, range.end.month, range.end.day)
        .add(const Duration(days: 1));

    return (dateToCheck.isAfter(startDate) && dateToCheck.isBefore(endDate));
  }
}
