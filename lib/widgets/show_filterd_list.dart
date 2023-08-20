import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sample/utils/colors.dart';
import 'package:sample/utils/enums.dart';
import 'package:sample/utils/flags.dart';
import 'package:sample/utils/styles.dart';
import 'package:sample/views/transaction_page/bloc/transaction_bloc_bloc.dart';
import 'package:sample/widgets/marlo_button.dart';
import 'package:sample/widgets/semi_circle.dart';

class ShowFilterLists extends StatelessWidget {
  const ShowFilterLists({super.key, required this.menuItems});
  final List<ShowMenuItems> menuItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        children: [
          for (var items in menuItems)
            MarloButton(
                title: items.title,
                onTap: () => _clearOneByOne(context, items),
                size: ButtonSize.small,
                style: MarloButtonStyle.secondary,
                axis: Direction.right,
                icon: Icons.close,
                circularImage: items.flag != null
                    ? _flagInAsset(items.flag!)
                    : items.flagName != null
                        ? _buildFlags(items.flagName!)
                        : null),
          if (menuItems.isNotEmpty)
            InkWell(
              onTap: () {
                context.read<TransactionBloc>().add(ClearAllFilterEvent());
              },
              child: Text(
                'Clear all',
                style: Styles.primary.copyWith(
                    color: MarloColors.buttonPrimary,
                    fontWeight: FontWeight.w600),
              ),
            ),
        ].expand((element) => [element, const SizedBox(width: 8)]).toList(),
      ),
    );
  }

  Widget _buildFlags(String country) {
    if (country == 'EUR') {
      return _buildEuroFlag();
    }
    if (country == 'SGD') {
      return _buildSingaporeFlag();
    }
    return _flagInAsset(country);
  }

  Stack _buildSingaporeFlag() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CircleAvatar(
          radius: 8,
          backgroundColor: Colors.red,
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 1),
              child: SizedBox(
                height: 6,
                width: 8,
                child: SvgPicture.asset(CountryFlags.singStar),
              ),
            ),
          ),
        ),
        const RotatedBox(
          quarterTurns: 2,
          child: MyArc(diameter: 16),
        )
      ],
    );
  }

  Widget _flagInAsset(String image) {
    return CircleAvatar(
      backgroundImage: NetworkImage(image),
      radius: 6,
    );
  }

  Widget _buildEuroFlag() {
    return CircleAvatar(
      backgroundColor: MarloColors.euroFlagPrimary,
      radius: 8,
      child: Center(
        child: SvgPicture.asset(
          CountryFlags.euroStar,
          width: 8,
          height: 8,
        ),
      ),
    );
  }

  _clearOneByOne(BuildContext context, ShowMenuItems menuItem) {
    if (menuItem.filterType == Filtering.currencies) {
      final list = context
          .read<TransactionBloc>()
          .state
          .filtering[Filtering.currencies] as List<String>;
      list.remove(menuItem.title);
      context
          .read<TransactionBloc>()
          .add(FilterCurrenciesEvent(currencies: list));
    }
    if (menuItem.filterType == Filtering.status) {
      final list = context
          .read<TransactionBloc>()
          .state
          .filtering[Filtering.status] as List<String>;
      list.remove(menuItem.title);
      context.read<TransactionBloc>().add(FilterStatusEvent(status: list));
    }

    if (menuItem.filterType == Filtering.time) {
      context.read<TransactionBloc>().add(FilterDateTimeRange(timeRange: null));
    }
  }
}

class ShowMenuItems {
  final Filtering filterType;
  final String? flag;
  final String? flagName;
  final String title;

  ShowMenuItems(
      {required this.filterType,
      this.flag,
      this.flagName,
      required this.title});
}
