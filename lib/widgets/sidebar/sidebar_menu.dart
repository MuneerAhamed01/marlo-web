import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sample/widgets/sidebar/utils/sidebar_menu_items.dart';

class SideBarMenuWidget extends StatelessWidget {
  const SideBarMenuWidget({super.key, required this.item});
  final SidebarMenu item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (item.title != null) ...[
          Text(
            item.title!.toUpperCase(),
            style: TextStyle(color: Colors.white.withOpacity(.4)),
          ),
          const SizedBox(height: 16),
        ],
        ...[for (SideBarMenuItems menu in item.items) _buildMenuItem(menu)]
      ],
    );
  }

  Widget _buildMenuItem(SideBarMenuItems menu) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          SizedBox(
            height: 32,
            width: 32,
            child: SvgPicture.asset(
              menu.icon,
            ),
          ),
          const SizedBox(width: 14),

          //TODO :REPLACE WITH STYLE
          Text(menu.title, style: TextStyle(color: Colors.white))
        ],
      ),
    );
  }
}
