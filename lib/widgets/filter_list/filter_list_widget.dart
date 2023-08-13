import 'package:flutter/material.dart';
import 'package:sample/utils/icons.dart';
import 'package:sample/utils/styles.dart';
import 'package:sample/widgets/marlo_button.dart';

class FilterListWidget extends StatelessWidget {
  const FilterListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: Row(
        children: [
          Text(
            'Quick filters:',
            style: Styles.primary.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 16),
          ...[
            MarloButton(
              title: 'All',
              onTap: () {},
              size: ButtonSize.small,
              icon: Icons.check_circle,
            ),
            MarloButton(
              title: 'Credit',
              onTap: () {},
              size: ButtonSize.small,
              style: MarloButtonStyle.secondary,
              svg: MarloIcons.credit,
            ),
            MarloButton(
              title: 'Debit',
              onTap: () {},
              size: ButtonSize.small,
              style: MarloButtonStyle.secondary,
              svg: MarloIcons.debit,
            )
          ]
              .expand((element) => [
                    element,
                    const SizedBox(width: 8),
                  ])
              .toList()
            ..removeLast()
        ],
      ),
    );
  }
}
