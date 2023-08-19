import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/services/transaction_services.dart';
import 'package:sample/utils/enums.dart';
import 'package:sample/views/transaction_page/model/transaction_model.dart';
part 'transaction_bloc_event.dart';
part 'transaction_bloc_state.dart';

class TransactionBloc extends Bloc<TransactionBlocEvent, TransactionBlocState> {
  final _transactionRepo = TransactionService.instance;
  TransactionBloc() : super(TransactionBlocInitial()) {
    on<GetTransactionEvent>(_getTransaction);
    on<FetchNextEvent>(_fetchNextPage);
    add(GetTransactionEvent());
  }

  void _getTransaction(
      TransactionBlocEvent event, Emitter<TransactionBlocState> emit) async {
    emit(LoadingTransactionState(filtering: state.filtering));
    final listTransaction = await _transactionRepo.getTransaction();
    print(state.filtering);
    if (listTransaction != null) {
      emit(
        LoadedTransaction(
          transaction: listTransaction,
          filtered: listTransaction.take(10).toList(),
          filtering: state.filtering,
        ),
      );
    }
  }

  void _fetchNextPage(
      FetchNextEvent event, Emitter<TransactionBlocState> emit) {
    final int offset =
        state.filtering[Filtering.pagination][PaginationEnum.offset];
    final int page = state.filtering[Filtering.pagination][PaginationEnum.page];
    final transactionLength = state.transaction.length;
    final to = min((offset * page) + page, transactionLength - 1);
    final isLast = to == transactionLength - 1;
    print('isLast :$isLast , page:($to) , length:(${transactionLength - 1})');

    final newTransaction =
        state.transaction.getRange((offset * page), to).toList();
    state.filtering[Filtering.pagination] = {
      PaginationEnum.offset: offset + 1,
      PaginationEnum.page: page
    };

    emit(
      LoadedTransaction(
        transaction: state.transaction,
        filtered: newTransaction,
        filtering: state.filtering,
        isLast: isLast,
      ),
    );
  }
}
