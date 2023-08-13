import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:sample/routes/base_beamer_delegate.dart';
import 'package:sample/routes/other_locations.dart';
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
      const BeamPage(
        key: ValueKey(transaction),
        name: transactionPath,
        title: transaction,
        child: TransactionPage(),
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
