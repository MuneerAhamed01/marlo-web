import 'package:beamer/beamer.dart';
import 'package:flutter/widgets.dart';

abstract class BaseBeamerDelegate extends BeamerDelegate {
  final Set<void Function(BuildContext, BeamerDelegate)> _buildListeners = {};

  BaseBeamerDelegate({
    required super.locationBuilder,
    super.initialPath,
    super.routeListener,
    super.updateListenable,
    super.removeDuplicateHistory,
    super.notFoundPage,
    super.notFoundRedirect,
    super.notFoundRedirectNamed,
    super.guards,
    super.navigatorObservers,
    super.transitionDelegate = const NoAnimationTransitionDelegate(),
    super.beamBackTransitionDelegate,
    super.onPopPage,
    super.setBrowserTabTitle = false,
    super.initializeFromParent,
    super.updateFromParent,
    super.updateParent,
    super.clearBeamingHistoryOn,
  });

  void addBuildListener(
    void Function(BuildContext context, BeamerDelegate delegate) listener,
  ) {
    _buildListeners.add(listener);
  }

  void removeBuildListener(
    void Function(BuildContext context, BeamerDelegate delegate) listener,
  ) {
    _buildListeners.remove(listener);
  }

  @override
  void Function(BuildContext, BeamerDelegate)? get buildListener =>
      _buildListener;

  void _buildListener(
    BuildContext context,
    BeamerDelegate delegate,
  ) {
    for (var l in _buildListeners) {
      l.call(context, delegate);
    }
  }
}
