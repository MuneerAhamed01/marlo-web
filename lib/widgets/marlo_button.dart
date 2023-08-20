import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sample/utils/colors.dart';
import 'package:sample/utils/styles.dart';

enum MarloButtonStyle { primary, secondary }

enum Direction { left, right }

enum ButtonSize { small, normal }

class MarloButton extends StatelessWidget {
  const MarloButton({
    super.key,
    required this.title,
    required this.onTap,
    this.style = MarloButtonStyle.primary,
    this.svg,
    this.icon,
    this.axis = Direction.left,
    this.size = ButtonSize.normal,
    this.circularImage,
  }) : assert(icon == null || svg == null);
  final String title;
  final Function() onTap;
  final MarloButtonStyle style;
  final String? svg;
  final IconData? icon;
  final Direction axis;
  final ButtonSize size;
  final Widget? circularImage;

  @override
  Widget build(BuildContext context) {
    final child = _ButtonText(
      axis: axis,
      title: title,
      icon: icon,
      svg: svg,
      style: style,
      size: size,
      circularImage: circularImage,
    );
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: onTap,
      child: style == MarloButtonStyle.primary
          ? _wrapWithPrimary(child)
          : _wrapWithSecondary(child),
    );
  }

  Container _wrapWithSecondary(Widget child) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: MarloColors.buttonPrimary.withOpacity(.2),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: child,
    );
  }

  _wrapWithPrimary(Widget child) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: MarloColors.buttonPrimary.withOpacity(.2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: child,
    );
  }
}

class _ButtonText extends StatelessWidget {
  const _ButtonText({
    this.axis = Direction.left,
    required this.title,
    this.svg,
    this.icon,
    this.size = ButtonSize.normal,
    required this.style,
    this.circularImage,
  });

  final Direction axis;
  final String title;
  final String? svg;
  final IconData? icon;
  final ButtonSize size;
  final MarloButtonStyle style;
  final Widget? circularImage;

  bool get _hasIcon => svg != null || icon != null;
  double get _textSize => size == ButtonSize.normal ? 14 : 12;
  double get _iconSize => size == ButtonSize.normal ? 24 : 14;
  Color get _color => style == MarloButtonStyle.primary
      ? MarloColors.buttonPrimary
      : Colors.black;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (circularImage != null) ...[
          circularImage!,
          const SizedBox(width: 2)
        ],
        if (axis == Direction.left && _hasIcon) _buildIcon(),
        Text(
          title,
          style: Styles.primary.copyWith(
            color: _color,
            fontWeight: FontWeight.w500,
            fontSize: _textSize,
          ),
        ),
        if (axis == Direction.right && _hasIcon) _buildIcon(),
      ],
    );
  }

  Widget _buildIcon() {
    if (icon != null) {
      return Padding(
        padding: const EdgeInsets.only(right: 2),
        child: Icon(
          icon,
          size: _iconSize,
          color: MarloColors.buttonPrimary,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(right: 4, top: 2),
        child: SvgPicture.asset(
          svg!,
          width: _iconSize - 4,
          height: _iconSize - 4,
          colorFilter: const ColorFilter.mode(
              MarloColors.buttonPrimary, BlendMode.srcIn),
        ),
      );
    }
  }
}
