import 'package:sample/utils/icons.dart';

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
      SideBarMenuItems(icon: MarloIcons.home, title: 'Home', route: ''),
      SideBarMenuItems(
          icon: MarloIcons.transactionMenu, title: 'Transactions', route: ''),
    ],
  ),
  SidebarMenu(
    title: 'essentials',
    items: [
      SideBarMenuItems(icon: MarloIcons.payMenu, title: 'Pay', route: ''),
      SideBarMenuItems(icon: MarloIcons.cards, title: 'Cards', route: ''),
      SideBarMenuItems(icon: MarloIcons.contacts, title: 'Contacts', route: ''),
    ],
  ),
  SidebarMenu(
    title: 'maritimes',
    items: [
      SideBarMenuItems(
          icon: MarloIcons.contracts, title: 'Contracts', route: ''),
      SideBarMenuItems(
          icon: MarloIcons.vesselIcon, title: 'Vessels', route: ''),
      SideBarMenuItems(
          icon: MarloIcons.marketRate, title: 'Market rates', route: ''),
    ],
  ),
  SidebarMenu(
    title: 'utilities',
    items: [
      SideBarMenuItems(
          icon: MarloIcons.reciveble, title: 'Receivables', route: ''),
      SideBarMenuItems(icon: MarloIcons.payable, title: 'Payables', route: ''),
      SideBarMenuItems(
          icon: MarloIcons.accounting, title: 'Accounting', route: ''),
      SideBarMenuItems(icon: MarloIcons.reports, title: 'Reports', route: ''),
    ],
  ),
  SidebarMenu(
    title: 'finance',
    items: [
      SideBarMenuItems(icon: MarloIcons.loans, title: 'Loans', route: ''),
    ],
  ),
  SidebarMenu(title: 'Tools', items: [
    SideBarMenuItems(icon: MarloIcons.loans, title: 'Loans', route: ''),
  ])
];
