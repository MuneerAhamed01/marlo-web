import 'package:beamer/beamer.dart';
import 'package:sample/routes/base_beamer_delegate.dart';
import 'package:sample/views/main_page/locations/main_page_location.dart';

class RootBeamerDelegate extends BaseBeamerDelegate {
  static final BaseBeamerDelegate instance = RootBeamerDelegate._();

  RootBeamerDelegate._()
      : super(
          initialPath: MainPageLocation.mainPath,
          locationBuilder: BeamerLocationBuilder(
            beamLocations: [
              MainPageLocation(),
            ],
          ),
        );
}
