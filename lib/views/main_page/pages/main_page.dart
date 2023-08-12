import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sample/utils/colors.dart';
import 'package:sample/utils/icons.dart';
import 'package:sample/widgets/sidebar/sidebar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: const Row(
        children: [SideBar()],
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
    return const Row(
      children: [
        Text(
          'MARLO TECHNOLOGIES',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
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
    return SizedBox(
      height: 24,
      width: 24,
      child: Center(
        child: SvgPicture.asset(icon),
      ),
    );
  }
}
