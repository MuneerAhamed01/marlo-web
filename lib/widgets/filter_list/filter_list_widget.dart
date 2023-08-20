import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sample/utils/colors.dart';
import 'package:sample/utils/enums.dart';
import 'package:sample/utils/icons.dart';
import 'package:sample/utils/styles.dart';
import 'package:sample/views/transaction_page/bloc/transaction_bloc_bloc.dart';
import 'package:sample/views/transaction_page/utils/transaction_country.dart';
import 'package:sample/widgets/action_menu.dart';
import 'package:sample/widgets/filter_list/date_picker.dart';
import 'package:sample/widgets/marlo_button.dart';

class FilterListWidget extends StatefulWidget {
  const FilterListWidget({super.key});

  @override
  State<FilterListWidget> createState() => _FilterListWidgetState();
}

class _FilterListWidgetState extends State<FilterListWidget> {
  TransactionBlocState state(BuildContext context) =>
      context.read<TransactionBloc>().state;

  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionBlocState>(
      builder: (context, state) {
        return SizedBox(
          height: 36,
          child: Row(
            children: [
              Text(
                'Quick filters:',
                style: Styles.primary.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 16),
              ...[
                MarloButton(
                  title: 'All',
                  onTap: () {
                    context.read<TransactionBloc>().add(ClearAllFilterEvent());
                    _maxController.clear();
                    _minController.clear();
                  },
                  size: ButtonSize.small,
                  style: context
                          .read<TransactionBloc>()
                          .state
                          .filtering
                          .keys
                          .toList()
                          .any((element) => element != Filtering.pagination)
                      ? MarloButtonStyle.secondary
                      : MarloButtonStyle.primary,
                  icon: Icons.check_circle,
                ),
                MarloButton(
                    title: 'Credit',
                    onTap: () => _onTapSource(context, SourceType.credit),
                    size: ButtonSize.small,
                    style:
                        _showActiveIconInSourceType(context, SourceType.credit)
                            ? MarloButtonStyle.primary
                            : MarloButtonStyle.secondary,
                    svg: MarloIcons.credit),
                MarloButton(
                  title: 'Debit',
                  onTap: () => _onTapSource(context, SourceType.debit),
                  size: ButtonSize.small,
                  style: _showActiveIconInSourceType(context, SourceType.debit)
                      ? MarloButtonStyle.primary
                      : MarloButtonStyle.secondary,
                  svg: MarloIcons.debit,
                ),
                ActionMenu(
                  title: 'Currencies',
                  menuItems: currencies,
                  onTap: (val) {
                    context
                        .read<TransactionBloc>()
                        .add(FilterCurrenciesEvent(currencies: val));
                  },
                  selectedItems:
                      state.filtering[Filtering.currencies] as List<String>? ??
                          [],
                ),
                ActionMenu(
                  title: 'Statuses',
                  menuItems: const ['PENDING', 'SETTLED', 'CANCELLED'],
                  onTap: (val) {
                    context
                        .read<TransactionBloc>()
                        .add(FilterStatusEvent(status: val));
                  },
                  selectedItems:
                      state.filtering[Filtering.status] as List<String>? ?? [],
                ),
                MarloButton(
                  title: 'Time range',
                  onTap: () async {
                    final date = await showPopUp(context);
                    if (date != null) {
                      // ignore: use_build_context_synchronously
                      context
                          .read<TransactionBloc>()
                          .add(FilterDateTimeRange(timeRange: date));
                    }
                  },
                  size: ButtonSize.small,
                  style: MarloButtonStyle.secondary,
                  icon: Icons.arrow_drop_down,
                  axis: Direction.right,
                ),
                Container(
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: MarloColors.buttonPrimary.withOpacity(.2),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      SvgPicture.asset(MarloIcons.dollar),
                      const SizedBox(width: 8),
                      ..._buildTextfield(
                        'Min amount',
                        _minController,
                      ),
                      const SizedBox(width: 8),
                      ..._buildTextfield(
                        'Max amount',
                        _maxController,
                      ),
                    ],
                  ),
                )
              ]
                  .expand((element) => [
                        element,
                        const SizedBox(width: 8),
                      ])
                  .toList()
                ..removeLast()
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildTextfield(
      String hintText, TextEditingController controller) {
    return [
      Container(
        height: 20,
        width: 1,
        color: MarloColors.buttonPrimary.withOpacity(.2),
      ),
      SizedBox(
        width: 80,
        height: 20,
        child: TextFormField(
          onChanged: (value) {
            final minAmount = int.tryParse(_minController.text);
            final maxAmount = int.tryParse(_maxController.text);
            context.read<TransactionBloc>().add(
                  FilterAmountEvent(
                    min: minAmount,
                    max: maxAmount,
                  ),
                );
          },
          controller: controller,
          scrollPhysics: const AlwaysScrollableScrollPhysics(),
          inputFormatters: [
            LengthLimitingTextInputFormatter(7),
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Styles.primary.copyWith(fontSize: 12),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 13).copyWith(left: 8),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      )
    ];
  }

  bool _showActiveIconInSourceType(BuildContext context, SourceType type) {
    final source =
        state(context).filtering[Filtering.sourceType] as List<SourceType>?;

    if (source != null) {
      return source.contains(type);
    }
    return false;
  }

  void _onTapSource(BuildContext context, SourceType type) {
    final source =
        state(context).filtering[Filtering.sourceType] as List<SourceType>?;
    if (source != null) {
      if (source.contains(type)) {
        context
            .read<TransactionBloc>()
            .add(FilterSourceTypeEvent(deactivateType: type));
        return;
      }
    }
    context
        .read<TransactionBloc>()
        .add(FilterSourceTypeEvent(activateType: type));
  }
}
