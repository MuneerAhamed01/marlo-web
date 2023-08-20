import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sample/utils/colors.dart';
import 'package:sample/utils/date_time_functions.dart';
import 'package:sample/utils/enums.dart';
import 'package:sample/utils/flags.dart';
import 'package:sample/utils/icons.dart';
import 'package:sample/utils/styles.dart';
import 'package:sample/views/transaction_page/bloc/transaction_bloc_bloc.dart';
import 'package:sample/widgets/filter_list/filter_list_widget.dart';
import 'package:sample/widgets/pagination_menu.dart';
import 'package:sample/widgets/payout_button.dart';
import 'package:sample/widgets/semi_circle.dart';
import 'package:sample/widgets/show_filterd_list.dart';
import 'package:sample/widgets/transaction_table/models/table_colums.dart';
import 'package:sample/widgets/transaction_table/transaction_table.dart';

import '../../widgets/marlo_button.dart';
import 'model/transaction_model.dart';
import 'utils/transaction_country.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionBlocState>(
      builder: (context, state) {
        if (state is LoadingTransactionState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is LoadedTransaction) {
          return _buildLayout(state, context);
        }
        return const Center(child: Text('Error'));
      },
    );
  }

  SingleChildScrollView _buildLayout(
      LoadedTransaction state, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black.withOpacity(.12),
                ),
              ),
            ),
            height: 88,
            child: _header(),
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 148,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: _buildCountryPounds,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemCount: getTransactionCountry().length + 1,
            ),
          ),
          const SizedBox(height: 24),
          _wrapWithPadding(
            Text(
              'Transactions',
              style: Styles.primary
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          const SizedBox(height: 16),
          _wrapWithPadding(const FilterListWidget()),
          const SizedBox(height: 16),
          _wrapWithPadding(ShowFilterLists(menuItems: _menuItems(state))),
          _wrapWithPadding(
            MarloTable(
              rows: transactionToTableColum(state.filteredList),
            ),
          ),
          const SizedBox(height: 24),
          _wrapWithPadding(
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PaginationMenu(
                  title: 'Currencies',
                  menuItems: const [5, 10, 15],
                  onTap: (val) {
                    context
                        .read<TransactionBloc>()
                        .add(ChangePageSizeEvent(val));
                  },
                  selectedNumber: state.paginatingPage,
                ),
                const SizedBox(width: 10),
                if (!state.isLast)
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      context.read<TransactionBloc>().add(FetchNextEvent());
                    },
                    child: Row(
                      children: [
                        Text(
                          'Next',
                          style: Styles.primary
                              .copyWith(color: MarloColors.buttonPrimary),
                        ),
                        const Icon(Icons.arrow_forward_ios,
                            size: 14, color: MarloColors.buttonPrimary)
                      ],
                    ),
                  )
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Row _header() {
    return Row(
      children: [
        SvgPicture.asset(MarloIcons.transactionMenu),
        const SizedBox(width: 16),
        Text(
          'Transaction /',
          style: Styles.primary.copyWith(
            color: MarloColors.primary,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        const SizedBox(width: 16),
        MarloButton(
          onTap: () {},
          title: "MARLO",
        ),
        const SizedBox(width: 28),
        Text(
          'HDFC · 5879',
          style: Styles.primary
              .copyWith(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(width: 28),
        MarloButton(
          onTap: () {},
          title: "Link account",
          style: MarloButtonStyle.secondary,
          icon: Icons.add,
        ),
        const Spacer(),
        const PayoutButton(),
      ],
    );
  }

  Padding _buildCountryPounds(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.only(
        left: index == 0 ? 24 : 0,
        right: getTransactionCountry().length == index ? 24 : 0,
      ),
      child: index == getTransactionCountry().length
          ? _buildAddNewCountry()
          : _buildTransaction(index),
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
          radius: 27,
          backgroundColor: Colors.red,
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SizedBox(
                height: 16,
                width: 21,
                child: SvgPicture.asset(CountryFlags.singStar),
              ),
            ),
          ),
        ),
        Container(
          height: 27,
          width: 54,
          color: Colors.white,
        ),
        const RotatedBox(
          quarterTurns: 2,
          child: MyArc(diameter: 54),
        )
      ],
    );
  }

  Widget _flagInAsset(String image, [double? radius]) {
    return CircleAvatar(
      backgroundImage: NetworkImage(image),
      radius: radius ?? 27,
    );
  }

  Widget _buildEuroFlag() {
    return CircleAvatar(
      backgroundColor: MarloColors.euroFlagPrimary,
      radius: 27,
      child: Center(
        child: SvgPicture.asset(CountryFlags.euroStar),
      ),
    );
  }

  _wrapWithPadding(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: child,
    );
  }

  Container _buildAddNewCountry() {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16).copyWith(bottom: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black.withOpacity(.10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundColor: MarloColors.singaporeSecondary,
            radius: 27,
            child: Center(
              child: Icon(
                Icons.add,
                color: MarloColors.iconColor,
                size: 27,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Add new',
            style: Styles.primary.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            'Global account',
            style: Styles.primary.copyWith(
              fontWeight: FontWeight.w400,
              color: MarloColors.subTitle,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildTransaction(int index) {
    final transaction = getTransactionCountry()[index];

    return Container(
      width: 140,
      padding: const EdgeInsets.all(16).copyWith(bottom: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black.withOpacity(.10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (transaction.flag != null)
                _flagInAsset(transaction.flag!)
              else
                _buildFlags(transaction.name),
              const Spacer(),
              Text(transaction.name)
            ],
          ),
          const SizedBox(height: 16),
          Text(
            transaction.amount,
            style: Styles.primary.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            transaction.sub,
            style: Styles.primary.copyWith(
              fontWeight: FontWeight.w400,
              color: MarloColors.subTitle,
            ),
          ),
        ],
      ),
    );
  }

  List<ShowMenuItems> _menuItems(LoadedTransaction state) {
    final filterList = state.filtering;
    final List<ShowMenuItems> showCaseMenu = [];

    if (filterList[Filtering.currencies] != null) {
      for (var element in (filterList[Filtering.currencies] as List<String>)) {
        final menu = ShowMenuItems(
          filterType: Filtering.currencies,
          title: element,
          flag: element == 'GBP'
              ? CountryFlags.gpb
              : element == 'USD'
                  ? CountryFlags.usd
                  : null,
          flagName: element,
        );
        showCaseMenu.add(menu);
      }
    }
    if (filterList[Filtering.status] != null) {
      for (var element in (filterList[Filtering.status] as List<String>)) {
        final menu = ShowMenuItems(
          filterType: Filtering.status,
          title: element,
        );
        showCaseMenu.add(menu);
      }
    }
    if (filterList[Filtering.time] != null) {
      final menu = ShowMenuItems(
        filterType: Filtering.time,
        title: formatDateTimeRange(filterList[Filtering.time] as DateTimeRange),
      );
      showCaseMenu.add(menu);
    }

    return showCaseMenu;
  }

  List<MarloTableColumn> transactionToTableColum(List<TransactionModel> data) {
    List<MarloTableColumn> tableData = [];
    for (var item in data) {
      final table = MarloTableColumn(
        name: item.description.isEmpty ? '--' : item.description,
        amount: item.amount,
        status: item.status.toUpperCase() == 'PENDING'
            ? TransactionStatus.processing
            : TransactionStatus.processed,
        source: item.sourceType,
        createdBy: item.createdAt,
      );
      tableData.add(table);
    }
    return tableData;
  }
}
