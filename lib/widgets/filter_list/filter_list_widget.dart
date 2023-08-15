import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sample/utils/colors.dart';
import 'package:sample/utils/icons.dart';
import 'package:sample/utils/styles.dart';
import 'package:sample/widgets/action_menu.dart';
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
            ),
            ActionMenu(
              title: 'Currencies',
              menuItems: [
                for (int i = 0; i < 10; i++) 'menu $i',
              ],
              onTap: (val) {},
              selectedItems: [],
            ),
            ActionMenu(
              title: 'Statuses',
              menuItems: [
                for (int i = 0; i < 10; i++) 'menu $i',
              ],
              onTap: (val) {},
              selectedItems: [],
            ),
            ActionMenu(
              title: 'Time range',
              menuItems: [
                for (int i = 0; i < 10; i++) 'menu $i',
              ],
              onTap: (val) {},
              selectedItems: [],
            ),
            Container(
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: MarloColors.buttonPrimary.withOpacity(.2),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  SvgPicture.asset(MarloIcons.dollar),
                  const SizedBox(width: 8),
                  Container(
                    height: 20,
                    width: 1,
                    color: MarloColors.buttonPrimary.withOpacity(.2),
                  ),
                  SizedBox(
                    width: 70,
                    height: 20,
                    child: TextFormField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 13)
                            .copyWith(left: 8),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
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
