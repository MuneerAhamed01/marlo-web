import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sample/utils/colors.dart';
import 'package:sample/utils/icons.dart';
import 'package:sample/utils/styles.dart';
import 'package:sample/widgets/transaction_table/models/table_colums.dart';
import 'package:sample/widgets/transaction_table/utils/transaction_type_enum.dart';

class MarloTable extends StatelessWidget {
  const MarloTable({super.key, required this.rows});
  final List<MarloTableColumn> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: MarloColors.borderColor),
      ),
      child: Column(
        children: [
          Container(
            height: 52,
            color: MarloColors.secondary,
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Row(
              children: [
                for (int i = 0; i < column.length; i++)
                  Expanded(
                    flex: i == 0 || i == column.length - 1 ? 2 : 1,
                    child: Text(
                      column[i],
                      style:
                          Styles.primary.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 48),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _TransactionName(
                      name: rows[i].name,
                      type: TransactionType.debit,
                    ),
                  ),
                  Expanded(
                    child: _buildRowText(rows[i].amount),
                  ),
                  Expanded(
                    child: _TransactionStatus(status: rows[i].status),
                  ),
                  Expanded(
                    child: Text(
                      rows[i].source,
                      style: Styles.primary.copyWith(
                          fontWeight: FontWeight.w400,
                          color: MarloColors.subTitle,
                          fontSize: 14),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(
                        _parseDateString(rows[i].createdBy),
                        style: Styles.primary.copyWith(
                            fontWeight: FontWeight.w400,
                            color: MarloColors.subTitle,
                            fontSize: 14),
                      ))
                ],
              ),
            )
        ],
      ),
    );
  }

  String _parseDateString(DateTime date) {
    final DateFormat dateFormat = DateFormat("EEE d MMM, h:mm a");
    return dateFormat.format(date);
  }

  Text _buildRowText(String text) {
    return Text(
      text,
      style: Styles.primary.copyWith(
          fontWeight: FontWeight.w400, color: MarloColors.secondaryLight),
    );
  }
}

class _TransactionStatus extends StatelessWidget {
  const _TransactionStatus({
    required this.status,
  });
  final TransactionStatus status;

  Color get _backgroundColor => status != TransactionStatus.processed
      ? MarloColors.primary.withOpacity(.2)
      : Colors.green.withOpacity(.3);
  Color get _textColor =>
      status != TransactionStatus.processed ? Colors.black : Colors.green;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: 74,
            decoration: BoxDecoration(
                color: _backgroundColor,
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text(
                status.name.replaceFirst(status.name.substring(0, 1),
                    status.name.substring(0, 1).toUpperCase()),
                style: Styles.primary.copyWith(fontSize: 10, color: _textColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionName extends StatelessWidget {
  const _TransactionName({
    required this.name,
    required this.type,
  });

  final String name;
  final TransactionType type;
  String get _icon =>
      type == TransactionType.credit ? MarloIcons.credit : MarloIcons.debit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: MarloColors.boxColor,
              borderRadius: BorderRadius.circular(6)),
          child: SvgPicture.asset(_icon),
        ),
        const SizedBox(width: 8),
        Text(
          name,
          style: Styles.primary.copyWith(
            fontWeight: FontWeight.w600,
            color: MarloColors.secondaryLight,
          ),
        )
      ],
    );
  }
}

List<String> column = [
  'transaction'.toUpperCase(),
  'amount'.toUpperCase(),
  'status'.toUpperCase(),
  'source'.toUpperCase(),
  'created by'.toUpperCase(),
];
