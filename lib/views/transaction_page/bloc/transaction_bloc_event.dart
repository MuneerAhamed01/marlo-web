part of 'transaction_bloc_bloc.dart';

class TransactionBlocEvent {}

class GetTransactionEvent extends TransactionBlocEvent {}

class FetchNextEvent extends TransactionBlocEvent {}

class ChangePageSizeEvent extends TransactionBlocEvent {
  final int pageSize;

  ChangePageSizeEvent(this.pageSize);
}

class FilterSourceType extends TransactionBlocEvent {
  final List<SourceType> activeSource;
  final List<SourceType> removedSource;

  FilterSourceType(
      {this.activeSource = const [], this.removedSource = const []});
}
