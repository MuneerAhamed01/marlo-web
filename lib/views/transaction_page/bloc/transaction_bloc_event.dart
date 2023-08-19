part of 'transaction_bloc_bloc.dart';

class TransactionBlocEvent {}

class GetTransactionEvent extends TransactionBlocEvent {}

class FetchNextEvent extends TransactionBlocEvent {}

class ChangePageSizeEvent extends TransactionBlocEvent {
  final int pageSize;

  ChangePageSizeEvent(this.pageSize);
}

class FilterSourceTypeEvent extends TransactionBlocEvent {
  final SourceType? activateType;
  final SourceType? deactivateType;

  FilterSourceTypeEvent({this.activateType, this.deactivateType});
}

class FilterCurrenciesEvent extends TransactionBlocEvent {
  final List<String> currencies;
  FilterCurrenciesEvent({
    required this.currencies,
  });
}

class FilterStatusEvent extends TransactionBlocEvent {
  List<String> status;
  FilterStatusEvent({
    required this.status,
  });
}

class FilterDateTimeRange extends TransactionBlocEvent {
  final DateTimeRange? timeRange;
  FilterDateTimeRange({
    this.timeRange,
  });
}
