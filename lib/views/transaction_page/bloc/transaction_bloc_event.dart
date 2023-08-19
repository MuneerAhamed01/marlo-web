part of 'transaction_bloc_bloc.dart';

class TransactionBlocEvent {}

class GetTransactionEvent extends TransactionBlocEvent {}

class FetchNextEvent extends TransactionBlocEvent {}

class ChangePageSizeEvent extends TransactionBlocEvent {
  final int pageSize;

  ChangePageSizeEvent(this.pageSize);
}

class FilterSourceTypeEvent extends TransactionBlocEvent {
  SourceType? activateType;
  SourceType? deactivateType;

  FilterSourceTypeEvent({this.activateType, this.deactivateType});
}
