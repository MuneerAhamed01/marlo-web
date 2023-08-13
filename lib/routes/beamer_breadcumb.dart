import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class BreadcrumbBeamPage extends BeamPage {
  final WidgetBuilder? breadCrumbContentBuilder;

  ///
  /// If this page is at the top of the page stack (it is the last page opened)
  /// and the value of this field is "true", then the corresponding crumb
  /// will be shown.
  /// If this page is at the top of the page stack, but the value of this field
  /// is "false", then the corresponding crumb will not be shown.
  ///
  final bool visibleIfLast;

  ///
  /// Specifies whether breadcrumb should be displayed on this page.
  /// If the value is "true", then a check is made on the number of pages
  /// to display breadcrumb (see [minPagesToShowBreadcrumb])
  ///
  final bool showBreadcrumb;

  ///
  /// Specifies what is the minimum number of pages that should be in the stack
  /// for breadcrumb to be displayed on this page
  ///
  final int minPagesToShowBreadcrumb;

  ///
  /// Specifies the page index on the stack from which the breadcrumb starts
  ///
  final int showFromIndex;

  const BreadcrumbBeamPage({
    required super.key,
    required String name,
    required super.child,
    super.title,
    super.onPopPage,
    super.popToNamed,
    super.type,
    super.routeBuilder,
    super.fullScreenDialog,
    super.opaque,
    super.keepQueryOnPop,
    this.breadCrumbContentBuilder,
    this.visibleIfLast = true,
    this.showBreadcrumb = true,
    this.minPagesToShowBreadcrumb = 2,
    this.showFromIndex = 0,
  }) : super(name:name);
}