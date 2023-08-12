import 'package:flutter/material.dart';
import 'package:sample/utils/colors.dart';
import 'package:sample/widgets/sidebar/sidebar_menu.dart';
import 'package:sample/widgets/sidebar/utils/sidebar_menu_items.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MarloColors.primary,
      width: 240,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildKYC(),
            const SizedBox(height: 16),
            ...[
              for (var item in menus) _buildSideBar(item),
            ]
          ],
        ),
      ),
    );
  }

  Padding _buildSideBar(SidebarMenu item) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: SideBarMenuWidget(item: item),
    );
  }

  Container _buildKYC() {
    return Container(
      color: MarloColors.kycBackground,
      height: 88,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //TODO: Change style
          Text(
            'Submit KYC (10%)',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(width: 2),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 16,
          )
        ],
      ),
    );
  }
}
