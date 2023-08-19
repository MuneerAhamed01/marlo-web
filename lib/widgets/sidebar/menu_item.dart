import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sample/utils/colors.dart';
import 'package:sample/utils/styles.dart';
import 'package:sample/widgets/sidebar/bloc/sidebar_bloc.dart';
import 'package:sample/widgets/sidebar/utils/sidebar_menu_items.dart';

class SidebarMenuItemWidget extends StatefulWidget {
  const SidebarMenuItemWidget({
    super.key,
    required this.menu,
    required this.onTap,
    this.selectedRoute,
  });
  final SideBarMenuItems menu;
  final Function() onTap;
  final String? selectedRoute;

  @override
  State<SidebarMenuItemWidget> createState() => _SidebarMenuItemWidgetState();
}

class _SidebarMenuItemWidgetState extends State<SidebarMenuItemWidget> {
  bool _isHovered = false;
  bool get _isCollapse => context.read<SidebarBloc>().state.isCollapsed;

  bool get _isColorChanged =>
      _isHovered || widget.selectedRoute == widget.menu.route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: _onHover,
        onExit: _onExit,
        child: Container(
          height: 40,
          color: _isColorChanged ? MarloColors.sidebarItemHover : null,
          margin: const EdgeInsets.only(
            bottom: 1,
          ),
          padding: _isCollapse ? null : const EdgeInsets.only(left: 16),
          child: Row(
            mainAxisAlignment: _isCollapse
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
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
                Expanded(
                  child: Text(widget.menu.title,
                      style: Styles.primary.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14)),
                )
              ]
            ],
          ),
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
