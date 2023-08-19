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
}
