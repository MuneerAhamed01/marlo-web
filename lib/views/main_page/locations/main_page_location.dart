import 'package:beamer/beamer.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sample/views/main_page/pages/main_page.dart';

class MainPageLocation extends BeamLocation<BeamState> {
  static const String mainPath = '/';

  @override

  List<Pattern> get pathPatterns => [mainPath, '$mainPath/*'];

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
