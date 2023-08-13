import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import 'beamer_breadcumb.dart';

class SideBarLocations extends BeamLocation<BeamState> {
  static const String home = 'home';
  static const String homePath = '/$home';
  @override
  List<Pattern> get pathPatterns => [homePath];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BreadcrumbBeamPage(
        key: ValueKey(home),
        name: homePath,
        child: Center(
          child: Text('Not currently'),
        ),
      )
    ];
  }
}
