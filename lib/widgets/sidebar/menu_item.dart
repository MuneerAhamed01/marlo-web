import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sample/utils/colors.dart';
import 'package:sample/widgets/sidebar/bloc/sidebar_bloc.dart';
import 'package:sample/widgets/sidebar/utils/sidebar_menu_items.dart';

class SidebarMenuItemWidget extends StatefulWidget {
  const SidebarMenuItemWidget({super.key, required this.menu});
  final SideBarMenuItems menu;

  @override
  State<SidebarMenuItemWidget> createState() => _SidebarMenuItemWidgetState();
}

class _SidebarMenuItemWidgetState extends State<SidebarMenuItemWidget> {
  bool _isHovered = false;
  bool get _isCollapse => context.read<SidebarBloc>().state.isCollapsed;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: _onHover,
      onExit: _onExit,
      child: Container(
        height: 40,
        color: _isHovered ? MarloColors.sidebarItemHover : null,
        margin: const EdgeInsets.only(
          bottom: 1,
        ),
        padding: _isCollapse ? null : const EdgeInsets.only(left: 16),
        child: Row(
          mainAxisAlignment:
              _isCollapse ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 32,
              width: 32,
              child: SvgPicture.asset(
                widget.menu.icon,
              ),
            ),
            if (!_isCollapse) ...[
              const SizedBox(width: 14),

              //TODO :REPLACE WITH STYLE
              Expanded(
                child: Text(widget.menu.title,
                    style: const TextStyle(color: Colors.white)),
              )
            ]
          ],
        ),
      ),
    );
  }

  _onHover(_) {
    setState(() {
      _isHovered = true;
    });
  }

  _onExit(_) {
    setState(() {
      _isHovered = false;
    });
  }
}
