import 'package:flutter/material.dart';
import 'package:sample/utils/colors.dart';
import 'package:sample/utils/styles.dart';
import 'package:sample/widgets/marlo_button.dart';

//TODO: Copy of action menu need to mege with [ActionMenu]

class PaginationMenu extends StatefulWidget {
  const PaginationMenu({
    super.key,
    required this.menuItems,
    required this.onTap,
    required this.selectedNumber,
    required this.title,
  });
  final List<int> menuItems;
  final Function(int) onTap;
  final int? selectedNumber;
  final String title;

  @override
  State<PaginationMenu> createState() => _PaginationMenuState();
}

class _PaginationMenuState extends State<PaginationMenu> {
  OverlayEntry? _overlayEntry;

  final LayerLink _layerLink = LayerLink();

  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: () {
          _toggleOverlay();
        },
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: MarloColors.subTitle.withOpacity(.1),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Center(
              child: Row(
            children: [
              Text(widget.selectedNumber.toString()),
              const Padding(
                padding: EdgeInsets.only(right: 2),
                child: Icon(
                  Icons.arrow_drop_down,
                  size: 24,
                  color: Colors.black,
                ),
              )
            ],
          )),
        ),
      ),
    );
  }

  Widget _buildOverlayWidget(BuildContext context) {
    return TapRegion(
      child: Column(
        children: [
          CompositedTransformFollower(
            offset: const Offset(0, -115),
            link: _layerLink,
            followerAnchor: Alignment.topLeft,
            child: Container(
              width: 60,
              constraints: const BoxConstraints(maxHeight: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2)
                  .copyWith(right: 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.menuItems
                        .map((e) => MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => _onChange(e),
                                child: Text(
                                  e.toString(),
                                  style: Styles.primary
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ))
                        .toList()
                        .expand(
                            (element) => [element, const SizedBox(height: 20)])
                        .toList()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _createOverlay() {
    _overlayEntry = OverlayEntry(builder: _buildOverlayWidget);
    Overlay.of(context).insert(_overlayEntry!);
  }

  _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  _toggleOverlay() {
    if (!_isOpen) {
      _createOverlay();
      _isOpen = true;
    } else {
      _removeOverlay();
      _isOpen = false;
    }
  }

  _onChange(int val) {
    widget.onTap(val);
    _toggleOverlay();
  }
}
