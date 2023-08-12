part of 'sidebar_bloc.dart';

abstract class SidebarEvent {}

class SidebarCollapseEvent extends SidebarEvent{
  final bool isCollapsed;

  SidebarCollapseEvent(this.isCollapsed);

}
