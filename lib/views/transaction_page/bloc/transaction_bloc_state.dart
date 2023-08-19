part of 'transaction_bloc_bloc.dart';

abstract class TransactionBlocState {
  final List<TransactionModel> transaction;
  final List<TransactionModel> filteredList;
  final Map<Filtering, dynamic> filtering;
  final bool isLast;

  TransactionBlocState({
    required this.transaction,
    required this.filteredList,
    required this.filtering,
    this.isLast = false,
  });

  int get paginatingPage =>
      filtering[Filtering.pagination][PaginationEnum.page];
}

class TransactionBlocInitial extends TransactionBlocState {
  static final page = {PaginationEnum.offset: 0, PaginationEnum.page: 10};
  TransactionBlocInitial()
      : super(
          transaction: [],
          filteredList: [],
          filtering: {Filtering.pagination: page},
        );
}

class LoadedTransaction extends TransactionBlocState {
  LoadedTransaction(
      {required List<TransactionModel> transaction,
      required List<TransactionModel> filtered,
      required Map<Filtering, dynamic> filtering,
      bool isLast = false})
      : super(
          transaction: transaction,
          filteredList: filtered,
          filtering: filtering,
          isLast: isLast,
        );
}

class LoadingTransactionState extends TransactionBlocState {
  LoadingTransactionState({
    super.transaction = const [],
    super.filteredList = const [],
    super.filtering = const {},
  });
}
