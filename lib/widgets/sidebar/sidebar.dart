import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/utils/colors.dart';
import 'package:sample/utils/styles.dart';
import 'package:sample/widgets/sidebar/bloc/sidebar_bloc.dart';
import 'package:sample/widgets/sidebar/sidebar_menu.dart';
import 'package:sample/widgets/sidebar/utils/sidebar_menu_items.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key, required this.onTapItem, this.initSelectedRoute});
  final Function(String) onTapItem;
  final String? initSelectedRoute;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SidebarBloc(),
      child: BlocBuilder<SidebarBloc, SidebarState>(
        builder: (context, state) {
          return MouseRegion(
            onEnter: (_) => _onHover(context),
            onExit: (_) => _onExit(context),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              color: MarloColors.primary,
              width: state.isCollapsed ? 96 : 240,
              height: double.infinity,
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (!state.isCollapsed) _buildKYC(),
                      SizedBox(height: state.isCollapsed ? 32 : 16),
                      ...[
                        for (var item in menus) _buildSideBar(item),
                      ]
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSideBar(SidebarMenu item) {
    return SideBarMenuWidget(item: item, onTap: onTapItem,initSelectedRoute: initSelectedRoute);
  }

  Container _buildKYC() {
    return Container(
      color: MarloColors.kycBackground,
      height: 88,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //TODO: Change style
          Flexible(
            child: Text(
              'Submit KYC (10%)',
              style: Styles.primary.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w200),
            ),
          ),
          const SizedBox(width: 2),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 16,
          )
        ],
      ),
    );
  }

  _onHover(BuildContext context) {
    context.read<SidebarBloc>().add(SidebarCollapseEvent(false));
  }

  _onExit(BuildContext context) {
    context.read<SidebarBloc>().add(SidebarCollapseEvent(true));
  }
}
