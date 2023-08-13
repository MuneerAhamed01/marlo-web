import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:sample/views/main_page/pages/main_page.dart';

class MainPageLocation extends BeamLocation<BeamState> {
  static const String mainPath = '/';

  @override
  List<Pattern> get pathPatterns => ["$mainPath*"];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey(mainPath),
        title: 'Main Page',
        child: MainPage(),
      ),
    ];
  }
}
