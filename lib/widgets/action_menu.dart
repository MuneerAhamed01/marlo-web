import 'package:flutter/material.dart';
import 'package:sample/utils/styles.dart';
import 'package:sample/widgets/marlo_button.dart';

class ActionMenu extends StatefulWidget {
  const ActionMenu({
    super.key,
    required this.menuItems,
    required this.onTap,
    required this.selectedItems,
    required this.title,
    
  });
  final List<String> menuItems;
  final Function(List<String>) onTap;
  final List<String> selectedItems;
  final String title;
  


  @override
  State<ActionMenu> createState() => _ActionMenuState();
}

class _ActionMenuState extends State<ActionMenu> {
  OverlayEntry? _overlayEntry;

  final LayerLink _layerLink = LayerLink();

  bool _isOpen = false;

  List<String> _selectedList = [];

  @override
  void initState() {
    super.initState();
    _selectedList = widget.selectedItems;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MarloButton(
        title: widget.title,
        onTap: _toggleOverlay,
        size: ButtonSize.small,
        style: MarloButtonStyle.secondary,
        icon: Icons.arrow_drop_down,
        axis: Direction.right,
      ),
    );
  }

  Widget _buildOverlayWidget(BuildContext context) {
    return TapRegion(
      onTapOutside: (_) {
        _toggleOverlay();
      },
      child: Column(
        children: [
          CompositedTransformFollower(
            offset: const Offset(0, 40),
            link: _layerLink,
            child: Container(
              width: 150,
              constraints: const BoxConstraints(maxHeight: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12)
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
                                child: Row(
                                  children: [
                                    Text(
                                      e,
                                      style: Styles.primary.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 10,
                                        width: 10,
                                        child: Checkbox(
                                          value: _isSelected(e),
                                          onChanged: (isSelect) => _onChange(e),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12)
                                  ],
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

  bool _isSelected(String value) {
    return _selectedList.contains(value);
  }

  _toggleOverlay() {
    if (!_isOpen) {
      _createOverlay();
      _isOpen = true;
    } else {
      widget.onTap(_selectedList);
      _removeOverlay();
      _isOpen = false;
    }
  }

  _onChange(String val) {
    if (_isSelected(val)) {
      _selectedList.remove(val);
    } else {
      _selectedList.add(val);
    }
    _overlayEntry?.markNeedsBuild();
  }
}
