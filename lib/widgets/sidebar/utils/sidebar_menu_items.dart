import 'package:sample/routes/other_locations.dart';
import 'package:sample/utils/icons.dart';
import 'package:sample/views/main_page/locations/main_content_locaions.dart';

class SidebarMenu {
  final String? title;
  final List<SideBarMenuItems> items;

  SidebarMenu({this.title, required this.items});
}

class SideBarMenuItems {
  final String icon;
  final String title;
  final String route;
  SideBarMenuItems({
    required this.icon,
    required this.title,
    required this.route,
  });
}

List<SidebarMenu> menus = [
  SidebarMenu(
    items: [
      SideBarMenuItems(
          icon: MarloIcons.home,
          title: 'Home',
          route: SideBarLocations.home),
      SideBarMenuItems(
          icon: MarloIcons.transaction,
          title: 'Transactions',
          route: MainContentLocation.transaction),
    ],
  ),
  SidebarMenu(
    title: 'essentials',
    items: [
      SideBarMenuItems(
          icon: MarloIcons.payMenu,
          title: 'Pay',
          route: SideBarLocations.home),
      SideBarMenuItems(
          icon: MarloIcons.cards,
          title: 'Cards',
          route: SideBarLocations.home),
      SideBarMenuItems(
          icon: MarloIcons.contacts,
          title: 'Contacts',
          route: SideBarLocations.home),
    ],
  ),
  SidebarMenu(
    title: 'maritimes',
    items: [
      SideBarMenuItems(
          icon: MarloIcons.contracts,
          title: 'Contracts',
          route: SideBarLocations.home),
      SideBarMenuItems(
          icon: MarloIcons.vesselIcon,
          title: 'Vessels',
          route: SideBarLocations.home),
      SideBarMenuItems(
          icon: MarloIcons.marketRate,
          title: 'Market rates',
          route: SideBarLocations.home),
    ],
  ),
  SidebarMenu(
    title: 'utilities',
    items: [
      SideBarMenuItems(
          icon: MarloIcons.reciveble,
          title: 'Receivables',
          route: SideBarLocations.home),
      SideBarMenuItems(
          icon: MarloIcons.payable,
          title: 'Payables',
          route: SideBarLocations.home),
      SideBarMenuItems(
          icon: MarloIcons.accounting,
          title: 'Accounting',
          route: SideBarLocations.home),
      SideBarMenuItems(
          icon: MarloIcons.reports,
          title: 'Reports',
          route: SideBarLocations.home),
    ],
  ),
  SidebarMenu(
    title: 'finance',
    items: [
      SideBarMenuItems(
          icon: MarloIcons.loans,
          title: 'Loans',
          route: SideBarLocations.home),
    ],
  ),
  SidebarMenu(title: 'Tools', items: [
    SideBarMenuItems(
        icon: MarloIcons.apps, title: 'Apps', route: SideBarLocations.home),
  ])
];
