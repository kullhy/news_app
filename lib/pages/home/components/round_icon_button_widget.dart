import 'package:flutter/material.dart';

import '../../../utils/constants/app_colors.dart';

class RoundIconButtonWidget extends StatefulWidget {
  const RoundIconButtonWidget({
    super.key,
    required this.iconColor,
    required this.iconWidth,
    required this.iconHeight,
    required this.borderColor,
    this.onTap,
    required this.iconName,
  });

  final Color borderColor;
  final String iconName;

  final Color iconColor;
  final double iconWidth;
  final double iconHeight;
  final Function()? onTap;

  @override
  State<RoundIconButtonWidget> createState() => _RoundIconButtonWidgetState();
}

class _RoundIconButtonWidgetState extends State<RoundIconButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.borderColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            widget.iconName,
            width: widget.iconWidth,
            height: widget.iconHeight,
            color: widget.iconColor,
          ),
        ),
      ),
    );
  }
}
