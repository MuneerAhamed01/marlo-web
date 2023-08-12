import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/widgets/sidebar/bloc/sidebar_bloc.dart';
import 'package:sample/widgets/sidebar/menu_item.dart';
import 'package:sample/widgets/sidebar/utils/sidebar_menu_items.dart';

class SideBarMenuWidget extends StatelessWidget {
  const SideBarMenuWidget({super.key, required this.item});
  final SidebarMenu item;

  isCollapse(BuildContext context) =>
      context.read<SidebarBloc>().state.isCollapsed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (item.title != null && !isCollapse(context)) ...[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 12),
            child: Text(
              item.title!.toUpperCase(),
              style: TextStyle(color: Colors.white.withOpacity(.4)),
            ),
          ),
          const SizedBox(height: 16),
        ],
        ...[for (SideBarMenuItems menu in item.items) _buildMenuItem(menu)]
      ],
    );
  }

  Widget _buildMenuItem(SideBarMenuItems menu) {
    return SidebarMenuItemWidget(menu: menu);
  }
}
