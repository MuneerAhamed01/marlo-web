import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/routes/base_beamer_delegate.dart';
import 'package:sample/routes/other_locations.dart';
import 'package:sample/views/transaction_page/bloc/transaction_bloc_bloc.dart';
import 'package:sample/views/transaction_page/transaction_page.dart';

class MainContentLocation extends BeamLocation<BeamState> {
  static const String transaction = 'transaction';
  static const String transactionPath = '/$transaction';
  @override
  List<Pattern> get pathPatterns => [transactionPath];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return _buildTransaction();
  }

  List<BeamPage> _buildTransaction() {
    return [
      BeamPage(
        key: const ValueKey(transaction),
        name: transactionPath,
        title: transaction,
        child: BlocProvider(
          create: (_) => TransactionBloc(),
          child: const TransactionPage(),
        ),
      )
    ];
  }
}

class MainContentDelegate extends BaseBeamerDelegate {
  static final BaseBeamerDelegate instance = MainContentDelegate._();

  MainContentDelegate._()
      : super(
            initialPath: MainContentLocation.transaction,
            locationBuilder: BeamerLocationBuilder(
              beamLocations: [
                MainContentLocation(),
                SideBarLocations(),
              ],
            ));
}
