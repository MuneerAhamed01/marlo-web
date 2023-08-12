part of 'sidebar_bloc.dart';

abstract class SidebarState {
  final bool isCollapsed;

  SidebarState({this.isCollapsed = true});
}

class SidebarInitial extends SidebarState {}

class SideBarCollapseState extends SidebarState {
  SideBarCollapseState({required super.isCollapsed});
}
