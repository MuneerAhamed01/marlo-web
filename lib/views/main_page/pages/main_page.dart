import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sample/utils/colors.dart';
import 'package:sample/utils/icons.dart';
import 'package:sample/utils/styles.dart';
import 'package:sample/views/main_page/locations/main_content_locaions.dart';
import 'package:sample/widgets/sidebar/sidebar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  static final GlobalKey<BeamerState> _nestedNavigationKey =
      GlobalKey<BeamerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MarloColors.backgroundColor,
      appBar: _buildAppBar(),
      body: Row(
        children: [
          SideBar(
              onTapItem: (route) {
                _nestedNavigationKey.currentState!.routerDelegate
                    .beamToNamed('/$route');
              },
              initSelectedRoute: MainContentLocation.transaction),
          Expanded(
            child: Beamer(
              key: _nestedNavigationKey,
              routerDelegate: MainContentDelegate.instance,
            ),
          )
        ],
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(
        backgroundColor: MarloColors.primary,
        elevation: 0,
        leadingWidth: 142,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: SvgPicture.asset(
            MarloIcons.marloFrame,
            width: 142,
            height: 30,
          ),
        ),
        actions: [
          _buildDropDown(),
          const SizedBox(width: 24),
          _buildButton(MarloIcons.bell),
          const SizedBox(width: 24),
          _buildButton(MarloIcons.profile),
          const SizedBox(width: 24),
        ],
      );

  Row _buildDropDown() {
    return Row(
      children: [
        Text(
          'MARLO TECHNOLOGIES',
          style: Styles.primary.copyWith(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 24,
          width: 24,
          child: Center(
            child: Icon(Icons.keyboard_arrow_down_outlined),
          ),
        )
      ],
    );
  }

  Widget _buildButton(String icon) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: SizedBox(
        height: 24,
        width: 24,
        child: Center(
          child: SvgPicture.asset(icon),
        ),
      ),
    );
  }
}
