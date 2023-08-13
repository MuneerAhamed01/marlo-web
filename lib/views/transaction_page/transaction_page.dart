import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sample/utils/colors.dart';
import 'package:sample/utils/flags.dart';
import 'package:sample/utils/icons.dart';
import 'package:sample/utils/styles.dart';
import 'package:sample/widgets/filter_list/filter_list_widget.dart';
import 'package:sample/widgets/payout_button.dart';
import 'package:sample/widgets/transaction_table/models/table_colums.dart';
import 'package:sample/widgets/transaction_table/transaction_table.dart';

import '../../widgets/marlo_button.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.black.withOpacity(.12)))),
            height: 88,
            child: Row(
              children: [
                SvgPicture.asset(MarloIcons.transactionMenu),
                const SizedBox(width: 16),
                Text(
                  'Transaction /',
                  style: Styles.primary.copyWith(
                    color: MarloColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(width: 16),
                MarloButton(
                  onTap: () {},
                  title: "MARLO",
                ),
                const SizedBox(width: 28),
                Text(
                  'HDFC · 5879',
                  style: Styles.primary
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(width: 28),
                MarloButton(
                  onTap: () {},
                  title: "Link account",
                  style: MarloButtonStyle.secondary,
                  icon: Icons.add,
                ),
                const Spacer(),
                const PayoutButton(),
              ],
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 148,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: _buildCountryPounds,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemCount: 10,
            ),
          ),
          const SizedBox(height: 24),
          _wrapWithPadding(
            Text(
              'Transactions',
              style: Styles.primary
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          const SizedBox(height: 16),
          _wrapWithPadding(const FilterListWidget()),
          const SizedBox(height: 72),
          _wrapWithPadding(MarloTable(rows: rows))
        ],
      ),
    );
  }

  Padding _buildCountryPounds(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.only(
        left: index == 0 ? 24 : 0,
        right: 9 == index ? 24 : 0,
      ),
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(16).copyWith(bottom: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black.withOpacity(.10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(CountryFlags.gpb),
                  radius: 27,
                ),
                Spacer(),
                Text('USD')
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '15,256,486.00',
              style: Styles.primary.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              'Main',
              style: Styles.primary.copyWith(
                fontWeight: FontWeight.w400,
                color: MarloColors.subTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _wrapWithPadding(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: child,
    );
  }
}

final rows = [
  for (int i = 0; i < 10; i++)
    MarloTableColumn(
      name: '$i Name',
      amount: '{$i}0000',
      status: TransactionStatus.processed,
      source: 'Payout',
      createdBy: DateTime.now(),
    )
];
