import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/services/transaction_services.dart';
import 'package:sample/utils/enums.dart';
import 'package:sample/views/transaction_page/model/transaction_model.dart';
import 'package:sample/views/transaction_page/utils/filter_service.dart';
part 'transaction_bloc_event.dart';
part 'transaction_bloc_state.dart';

class TransactionBloc extends Bloc<TransactionBlocEvent, TransactionBlocState> {
  final _transactionRepo = TransactionService.instance;
  final FilterService _filterService = FilterService.instance;
  TransactionBloc() : super(TransactionBlocInitial()) {
    on<GetTransactionEvent>(_getTransaction);
    on<FetchNextEvent>(_fetchNextPage);
    on<ChangePageSizeEvent>(_changePageSizeEvent);
    on<FilterSourceTypeEvent>(_sourceTypeFilter);
    on<FilterCurrenciesEvent>(_currencyFilterEvent);
    on<FilterStatusEvent>(_statusFilter);
    on<FilterDateTimeRange>(_dateTimeFilter);
    on<FilterAmountEvent>(_filterAmount);
    add(GetTransactionEvent());
  }

  void _getTransaction(
      TransactionBlocEvent event, Emitter<TransactionBlocState> emit) async {
    emit(LoadingTransactionState(filtering: state.filtering));
    final listTransaction = await _transactionRepo.getTransaction();
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
    final filteredList = _applyFilter();

    final int offset =
        state.filtering[Filtering.pagination][PaginationEnum.offset];
    final int page = state.filtering[Filtering.pagination][PaginationEnum.page];
    final transactionLength = filteredList.length;
    final to = min((offset * page) + page, transactionLength - 1);
    final isLast = to == transactionLength - 1;
    print('isLast :$isLast , page:($to) , length:(${transactionLength - 1})');

    final newTransaction = filteredList.getRange((offset * page), to).toList();
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

  void _changePageSizeEvent(
      ChangePageSizeEvent event, Emitter<TransactionBlocState> emit) {
    state.filtering[Filtering.pagination] = {
      PaginationEnum.offset: 0,
      PaginationEnum.page: event.pageSize
    };
    final filteredList = _applyFilter();
    final newTransaction =
        filteredList.take(min(event.pageSize, filteredList.length));

    emit(
      LoadedTransaction(
        transaction: state.transaction,
        filtered: newTransaction.toList(),
        filtering: state.filtering,
        isLast: newTransaction.length == filteredList.length,
      ),
    );
    //
  }

  void _sourceTypeFilter(
      FilterSourceTypeEvent event, Emitter<TransactionBlocState> emit) {
    final List<SourceType>? filter = state.filtering[Filtering.sourceType];
    if (event.activateType != null) {
      state.filtering[Filtering.sourceType] = [
        if (filter != null) ...filter,
        event.activateType!
      ];
    }
    if (event.deactivateType != null) {
      if (filter != null) {
        (state.filtering[Filtering.sourceType] as List<SourceType>)
            .remove(event.deactivateType!);
      }
      if ((state.filtering[Filtering.sourceType] as List).isEmpty) {
        state.filtering[Filtering.sourceType] = null;
      }
    }

    state.filtering[Filtering.pagination] = {
      PaginationEnum.offset: 0,
      PaginationEnum.page: state.paginatingPage
    };
    final filteredList = _applyFilter();
    final newTransaction =
        filteredList.take(min(state.paginatingPage, filteredList.length));
    emit(
      LoadedTransaction(
        transaction: state.transaction,
        filtered: newTransaction.toList(),
        filtering: state.filtering,
        isLast: newTransaction.length == filteredList.length,
      ),
    );
  }

  void _currencyFilterEvent(
      FilterCurrenciesEvent event, Emitter<TransactionBlocState> emit) {
    if (event.currencies.isNotEmpty) {
      state.filtering[Filtering.currencies] = event.currencies;
    } else {
      state.filtering[Filtering.currencies] = null;
    }

    state.filtering[Filtering.pagination] = {
      PaginationEnum.offset: 0,
      PaginationEnum.page: state.paginatingPage
    };
    final filteredList = _applyFilter();
    final newTransaction =
        filteredList.take(min(state.paginatingPage, filteredList.length));
    emit(
      LoadedTransaction(
        transaction: state.transaction,
        filtered: newTransaction.toList(),
        filtering: state.filtering,
        isLast: newTransaction.length == filteredList.length,
      ),
    );
  }

  void _statusFilter(
      FilterStatusEvent event, Emitter<TransactionBlocState> emit) {
    if (event.status.isNotEmpty) {
      state.filtering[Filtering.status] = event.status;
    } else {
      state.filtering[Filtering.status] = null;
    }

    state.filtering[Filtering.pagination] = {
      PaginationEnum.offset: 0,
      PaginationEnum.page: state.paginatingPage
    };
    final filteredList = _applyFilter();
    final newTransaction =
        filteredList.take(min(state.paginatingPage, filteredList.length));
    emit(
      LoadedTransaction(
        transaction: state.transaction,
        filtered: newTransaction.toList(),
        filtering: state.filtering,
        isLast: newTransaction.length == filteredList.length,
      ),
    );
  }

  void _dateTimeFilter(
      FilterDateTimeRange event, Emitter<TransactionBlocState> emit) {
    state.filtering[Filtering.time] = event.timeRange;

    state.filtering[Filtering.pagination] = {
      PaginationEnum.offset: 0,
      PaginationEnum.page: state.paginatingPage
    };
    final filteredList = _applyFilter();
    final newTransaction =
        filteredList.take(min(state.paginatingPage, filteredList.length));
    emit(
      LoadedTransaction(
        transaction: state.transaction,
        filtered: newTransaction.toList(),
        filtering: state.filtering,
        isLast: newTransaction.length == filteredList.length,
      ),
    );
  }

  void _filterAmount(
      FilterAmountEvent event, Emitter<TransactionBlocState> emit) {
    state.filtering[Filtering.min] = event.min;
    state.filtering[Filtering.max] = event.max;

    state.filtering[Filtering.pagination] = {
      PaginationEnum.offset: 0,
      PaginationEnum.page: state.paginatingPage
    };
    final filteredList = _applyFilter();
    final newTransaction =
        filteredList.take(min(state.paginatingPage, filteredList.length));
    emit(
      LoadedTransaction(
        transaction: state.transaction,
        filtered: newTransaction.toList(),
        filtering: state.filtering,
        isLast: newTransaction.length == filteredList.length,
      ),
    );
  }

  List<TransactionModel> _applyFilter() {
    List<TransactionModel> filteringList = state.transaction;
    final hasSourceType =
        state.filtering[Filtering.sourceType] as List<SourceType>?;
    final currencies = state.filtering[Filtering.currencies] as List<String>?;
    final timeRange = state.filtering[Filtering.time] as DateTimeRange?;
    final min = state.filtering[Filtering.min] as int?;
    final max = state.filtering[Filtering.max] as int?;
    final status = state.filtering[Filtering.status] as List<String>?;

    if (hasSourceType?.isNotEmpty ?? false) {
      filteringList = filteringList
          .toSet()
          .intersection(_filterService
              .sourceTypeFilter(filteringList, hasSourceType!)
              .toSet())
          .toList();
    }

    if (currencies?.isNotEmpty ?? false) {
      filteringList = filteringList
          .toSet()
          .intersection(_filterService
              .currenciesFilter(filteringList, currencies!)
              .toSet())
          .toList();
    }

    if (status?.isNotEmpty ?? false) {
      filteringList = filteringList
          .toSet()
          .intersection(
              _filterService.statusFilter(filteringList, status!).toSet())
          .toList();
    }

    if (timeRange != null) {
      filteringList = filteringList
          .toSet()
          .intersection(
              _filterService.dateFilter(filteringList, timeRange).toSet())
          .toList();
    }

    if (min != null || max != null) {
      filteringList = filteringList
          .toSet()
          .intersection(_filterService
              .filterMinMax(filteringList, maxValue: max, minValue: min)
              .toSet())
          .toList();
    }
    return filteringList;
  }
}
